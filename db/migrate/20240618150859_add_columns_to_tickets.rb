class AddColumnsToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :category, :integer
    add_column :tickets, :description, :string
  end
end
