class RemoveIsActiveQuestionMarkAddIsActive < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :is_active?, :boolean, default: true
    add_column :projects, :is_active, :boolean, default: true
  end
end
