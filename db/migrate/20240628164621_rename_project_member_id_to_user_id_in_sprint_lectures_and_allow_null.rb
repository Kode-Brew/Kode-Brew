class RenameProjectMemberIdToUserIdInSprintLecturesAndAllowNull < ActiveRecord::Migration[7.1]
  def change
    rename_column :sprint_lectures, :project_member_id, :user_id
    change_column_null :sprint_lectures, :user_id, true
  end
end
