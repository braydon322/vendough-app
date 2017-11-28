class User < ApplicationRecord
  has_many :transactions, foreign_key: "sender_id"
  has_many :recipients, through: :transactions
  has_many :inverse_transactions, :class_name => "Transaction", :foreign_key => "recipient_id"
  has_many :inverse_recipients, :through => :inverse_transactions, :source => :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
    where.not("id = ?", current_user.id)
  end

  def requests_awaiting_approval_by_others
    # SELECT  "transactions".*
    # FROM "transactions"
    # WHERE "transactions"."sender_id" = self.id
    # AND "transactions"."status" = "incomplete"
    transactions.where(status: "incomplete")
  end

  def requests_for_money_from_others
    # SELECT  "transactions".*
    # FROM "transactions"
    # WHERE "transactions"."recipient_id" = self.id
    # AND "transactions"."status" = "incomplete"
    inverse_transactions.where(status: "incomplete")
  end
end
