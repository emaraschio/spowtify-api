class PlaylistSong < ApplicationRecord
  belongs_to :song
  belongs_to :playlist

  validates_presence_of :playlist
  validates_presence_of :song
end
