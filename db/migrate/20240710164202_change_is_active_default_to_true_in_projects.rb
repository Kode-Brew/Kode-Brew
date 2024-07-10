class ChangeIsActiveDefaultToTrueInProjects < ActiveRecord::Migration[7.1]
  def change
    change_column_default :projects, :is_active?, from: nil, to: true
  end
end
