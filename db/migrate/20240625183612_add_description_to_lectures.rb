class AddDescriptionToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :description, :text
  end
end
