class AddActiveSprintToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :active_sprint, :integer, default: 1
  end
end
