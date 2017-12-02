class Tag < ApplicationRecord
  has_many :dealing_tags, dependent: :destroy
  has_many :dealings, through: :dealing_tags, dependent: :destroy

  def self.completed_by_name
    joins(:dealings).where(:dealings => {status: "complete"}).group(:id).order(:name)
    # SELECT tags.* FROM tags
    # INNER JOIN dealing_tags
    # ON tags.id = dealing_tags.tag_id
    # INNER JOIN dealings
    # ON dealings.id = dealing_tags.dealing_id
    # WHERE dealings.status = "complete"
    # GROUP BY tags.id
    # ORDER BY tags.name
  end
end
