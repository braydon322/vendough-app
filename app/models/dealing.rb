class Dealing < ApplicationRecord
  alias_attribute :user, :sender
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
  has_many :dealing_tags, dependent: :destroy
  has_many :tags, through: :dealing_tags, dependent: :destroy
  validates :recipient, presence: true
  validates :amount, presence: true
  validates_numericality_of :amount, :greater_than => 0, :message => "entered <= $0"
  validates_numericality_of :amount, :less_than_or_equal_to => 2000, :message => "entered >= $2000"
  validates :description, presence: true
  validates :description, length: { maximum: 35, :message => "must be < than 35 char" }
  validates :action, presence: true
  validates :action, inclusion: { in: %w(pay request), message: "request/pay tampered"}

  def tags_attributes=(tag_attributes)
    unless tag_attributes.values.first.values.first.empty?
      hashtags = tag_attributes.values.first.values.first.split(" ")
      hashtags.each do |hashtag|
        hashtag = Tag.find_or_create_by(name: hashtag)
        self.tags << hashtag
      end
    end
  end

  def self.newest_first
    where(status: "complete").order(updated_at: 'DESC')
  end

  def self.all_with_tags_completed(tag)
    joins(:tags).where(:dealings => {status: "complete"}, :tags => {id: tag.id}).order(updated_at: 'DESC')
    # SELECT dealings.* FROM dealings
    # INNER JOIN dealing_tags
    # ON dealings.id = dealing_tags.dealing_id
    # INNER JOIN tags
    # ON dealing_tags.tag_id = tags.id
    # WHERE dealings.status = "complete" AND tags.name = "#pepsi"
    # ORDER BY dealings.id DESC
  end

  def self.user_dealings(user)
    where("status = ? AND (sender_id = ? OR recipient_id = ?)", "complete",  user.id, user.id).order(updated_at: :desc)
  end

  def sender_name
    sender.name
  end

  def recipient_name
    recipient.name
  end

  def concise_date
    (self.created_at - 25200).strftime("%b %d")
  end

  def exact_date
    (self.created_at - 25200).strftime("%b %d, %Y %I:%M %p")
  end

  def pay_dealing
    sender.credit -= amount
    recipient.credit += amount
    self.status = "complete"
  end

  def approve_dealing
    sender.credit += amount
    recipient.credit -= amount
    self.status = "complete"
  end

end
