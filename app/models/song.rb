class Song < ApplicationRecord
  belongs_to :album
  belongs_to :artist

  validates_presence_of :name, :duration, :genre
end
