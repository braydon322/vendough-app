class TransactionTag < ApplicationRecord
  belongs_to :dealing, class_name: "Transaction"
  belongs_to :tag
end
