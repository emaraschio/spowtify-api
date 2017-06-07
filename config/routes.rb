Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :albums
    resources :artists
    resources :playlists
    resources :songs
  end
end
