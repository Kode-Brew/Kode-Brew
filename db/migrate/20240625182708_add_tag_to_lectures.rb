class AddTagToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :tag, :string
  end
end
