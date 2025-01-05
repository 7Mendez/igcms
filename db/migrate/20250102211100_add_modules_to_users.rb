class AddModulesToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :modules, :string, array: true, default: []
  end
end
