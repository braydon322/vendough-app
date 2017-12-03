class User < ApplicationRecord
  validates_numericality_of :credit, :greater_than_or_equal_to => 0, :message => "Insufficient funds to complete transaction."
  has_many :dealings, foreign_key: "sender_id"
  has_many :recipients, through: :dealings
  has_many :inverse_dealings, :class_name => "Dealing", :foreign_key => "recipient_id"
  has_many :inverse_recipients, :through => :inverse_dealings, :source => :user
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.name = auth.info.name
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
   end
  end

  def self.contacts(current_user)
    where.not("id = ?", current_user.id).order(:name)
  end

  def requests_awaiting_approval_by_others
    # SELECT  "dealings".*
    # FROM "dealings"
    # WHERE "dealings"."sender_id" = self.id
    # AND "dealings"."status" = "incomplete"
    dealings.where(status: "incomplete").order(id: "DESC")
  end

  def requests_for_money_from_others
    # SELECT  "dealings".*
    # FROM "dealings"
    # WHERE "dealings"."recipient_id" = self.id
    # AND "dealings"."status" = "incomplete"
    inverse_dealings.where(status: "incomplete").order(id: "DESC")
  end
end
