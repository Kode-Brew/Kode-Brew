class ModifyUserIdInLecturesAndSprintLectures < ActiveRecord::Migration[7.1]
  def change
    add_reference :lectures, :user, foreign_key: true, null: true

    remove_column :sprint_lectures, :user_id, :bigint
  end
end
