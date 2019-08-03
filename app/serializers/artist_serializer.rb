class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :genre_type, :created_at, :updated_at

  has_many :albums
end