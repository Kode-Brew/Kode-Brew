class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :priority
      t.string :description
      t.string :status
      t.integer :points
      t.references :user, null: false, foreign_key: true
      t.references :sprint, null: false, foreign_key: true
      t.timestamps
    end
  end
end
