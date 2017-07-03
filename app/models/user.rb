class User < ApplicationRecord
  has_secure_password

  has_many :playlists, foreign_key: :user_id
  has_many :artists, foreign_key: :user_id
  has_many :songs, foreign_key: :user_id
  has_many :albums, foreign_key: :user_id

  validates_presence_of :name, :email, :password_digest
end
