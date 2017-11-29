class CreateDealingTags < ActiveRecord::Migration[5.1]
  def change
    create_table :dealing_tags do |t|
      t.belongs_to :dealing, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
