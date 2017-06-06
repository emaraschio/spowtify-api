class Artist < ApplicationRecord
  has_many :songs, dependent: :destroy
  has_many :albums, dependent: :destroy

  validates_presence_of :name, :type, :bio
end
