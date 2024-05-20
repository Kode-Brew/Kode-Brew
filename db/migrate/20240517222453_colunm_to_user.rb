class ColunmToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :string, null: false
    add_column :users, :points, :string
  end
end
