class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.time :duration
      t.references :album, foreign_key: true
      t.boolean :featured, default: false
      t.string :description
      t.string :image_url
      t.string :genre

      t.timestamps
    end
  end
end
