class AddSocialFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :linkedin, :string
    add_column :users, :slack, :string
    add_column :users, :github, :string
  end
end
