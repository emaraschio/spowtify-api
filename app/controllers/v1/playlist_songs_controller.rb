module V1
  class PlaylistSongsController < ApplicationController
    before_action :set_playlist_song, only: [:destroy]
    swagger_controller :users, "Playlist's Songs Management"

    swagger_api :create do |api|
      summary "add a song to a playlist"
      PlaylistSongsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /playlist_songs
    def create
      @playlist_song = PlaylistSong.create!(playlist_song_params)
      json_response(@playlist_song, :created)
    end

    swagger_api :destroy do
      summary "Remove a song from a Playlist"
      param :path, :id, :integer, :required, "ID of Playlist Song"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /playlist_songs/:id
    def destroy
      @playlist_song.destroy
      head :no_content
    end

    private

    def self.add_common_params(api) 
      api.param :form, "playlist_id", :integer, :required, "Playlist ID"
      api.param :form, "song_id", :time, :required, "Song ID"
    end

    def playlist_song_params
      params.permit(:playlist_id, :song_id)
    end

    def set_playlist_song
      @playlist_song = PlaylistSong.find(params[:id]) if params[:id]
    end
  end
end
