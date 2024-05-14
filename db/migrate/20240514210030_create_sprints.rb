class CreateSprints < ActiveRecord::Migration[7.1]
  def change
    create_table :sprints do |t|
      t.references :project, null: false, foreign_key: true
      t.date :date_start
      t.date :date_end
      t.string :objective
      t.timestamps
    end
  end
end
