class FixColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :dealings, :disburser_id, :sender_id
    rename_column :dealings, :collector_id, :recipient_id
  end
end
