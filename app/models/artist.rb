class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy
  has_many :albums, dependent: :destroy

  validates_presence_of :name, :genre_type, :bio
end
