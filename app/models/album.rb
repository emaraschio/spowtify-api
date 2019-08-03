class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates_presence_of :name, :art, :abstract
end
