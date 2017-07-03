class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :art
      t.string :abstract
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
