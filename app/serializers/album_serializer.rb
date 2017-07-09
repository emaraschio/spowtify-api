class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :art, :abstract, :created_at, :updated_at

  belongs_to :artist
  has_many :songs
end