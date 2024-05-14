class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :category
      t.string :name
      t.string :address
      t.string :email
      t.string :cell_phone
      t.timestamps
    end
  end
end
