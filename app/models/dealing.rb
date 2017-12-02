class Dealing < ApplicationRecord
  alias_attribute :user, :sender
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
  has_many :dealing_tags, dependent: :destroy
  has_many :tags, through: :dealing_tags, dependent: :destroy
  validates :recipient, presence: true
  validates :amount, presence: true
  validates_numericality_of :amount, :greater_than => 0, :message => "Please enter an amount greater than 0."
  validates :description, presence: true
  validates :description, length: { maximum: 35, :message => "Please keep the description to 35 characters." }
  validates :action, presence: true
  validates :action, inclusion: { in: %w(pay request), message: "radio button values have been tampered with."}

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
    where(status: "complete").order('id DESC')
  end

  def self.all_with_tags_completed(tag)
    joins(:tags).where(:dealings => {status: "complete"}, :tags => {id: tag.id}).order(id: 'DESC')
    # SELECT dealings.* FROM dealings
    # INNER JOIN dealing_tags
    # ON dealings.id = dealing_tags.dealing_id
    # INNER JOIN tags
    # ON dealing_tags.tag_id = tags.id
    # WHERE dealings.status = "complete" AND tags.name = "#pepsi"
    # ORDER BY dealings.id DESC
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
    sender.save
    recipient.save
  end

end
