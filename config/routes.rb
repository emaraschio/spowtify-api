Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :artists do
      resources :albums
      resources :songs
    end
    resources :playlists
    resources :playlist_songs
  end
end
