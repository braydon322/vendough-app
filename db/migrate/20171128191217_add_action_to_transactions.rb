class AddActionToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :action, :string
  end
end
