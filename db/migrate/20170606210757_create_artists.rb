class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :bio
      t.string :genre_type

      t.timestamps
    end
  end
end
