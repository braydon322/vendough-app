class TransactionTag < ApplicationRecord
  belongs_to :dealing, class_name: "Transaction", foreign_key: "transaction_id"
  belongs_to :tag
end
