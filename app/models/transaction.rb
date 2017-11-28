class Transaction < ApplicationRecord
  alias_attribute :user, :sender
  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
  # before_save :pay_transaction, if: :status == "sending"

  def self.newest_first
    where(status: "complete").order('id DESC')
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

  def pay_transaction
    sender.credit -= amount
    recipient.credit += amount
    self.status = "complete"
    sender.save
    recipient.save
  end

  def approve_transaction
    # binding.pry
    sender.credit += amount
    recipient.credit -= amount
    self.status = "complete"
    sender.save
    recipient.save
  end




end
