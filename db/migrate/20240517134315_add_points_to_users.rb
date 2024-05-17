class AddPointsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :points, :string
  end
end
