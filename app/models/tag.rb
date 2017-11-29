class Tag < ApplicationRecord
  has_many :dealing_tags
  has_many :dealings, through: :dealing_tags
end
