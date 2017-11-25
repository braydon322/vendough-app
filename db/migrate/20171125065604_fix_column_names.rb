class FixColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :disburser_id, :sender_id
    rename_column :transactions, :collector_id, :recipient_id
  end
end
