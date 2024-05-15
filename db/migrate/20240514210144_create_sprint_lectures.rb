class CreateSprintLectures < ActiveRecord::Migration[7.1]
  def change
    create_table :sprint_lectures do |t|
      t.references :sprint, null: false, foreign_key: true
      t.references :lecture, null: false, foreign_key: true
      t.references :project_member, null: true, foreign_key: true
      t.timestamps
    end
  end
end
