class Tag < ApplicationRecord
  has_many :transaction_tags
  has_many :dealings, through: :transaction_tags, foreign_key: "tag_id", class_name: "Transaction" 
end
