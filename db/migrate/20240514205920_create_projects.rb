class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :client, null: true, foreign_key: true
      t.string :name
      t.string :category
      t.string :description
      t.boolean :is_active?
      t.timestamps
    end
  end
end
