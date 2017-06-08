class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at

  has_many :songs
end