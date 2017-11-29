class AddActionToDealings < ActiveRecord::Migration[5.1]
  def change
    add_column :dealings, :action, :string
  end
end
