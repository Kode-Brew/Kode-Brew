class CreateLectures < ActiveRecord::Migration[7.1]
  def change
    create_table :lectures do |t|
      t.string :title, null: false
      t.string :source, null: false
      t.text :video, null: false
      t.text :slide, null: false
      t.timestamps
    end
  end
end
