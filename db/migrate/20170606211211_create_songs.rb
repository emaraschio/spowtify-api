class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.time :duration
      t.references :album, foreign_key: true
      t.references :artist, foreign_key: true
      t.string :genre

      t.timestamps
    end
  end
end
