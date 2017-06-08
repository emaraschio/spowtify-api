class PlaylistSongSerializer < ActiveModel::Serializer
  attributes :id, :song_id, :playlist_id, :created_at, :updated_at

  belongs_to :song
end