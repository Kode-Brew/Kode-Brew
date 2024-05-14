class CreateProjectMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :project_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :user_type
      t.timestamps
    end
  end
end
