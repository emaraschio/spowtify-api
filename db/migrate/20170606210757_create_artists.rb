class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :bio
      t.string :genre_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
