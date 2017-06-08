module V1
  class PlaylistSongsController < ApplicationController
    before_action :set_playlist_song, only: [:destroy]

    # POST /playlist_songs
    def create
      @playlist_song = PlaylistSong.create!(playlist_song_params)
      json_response(@playlist_song, :created)
    end

    # DELETE /playlist_songs/:id
    def destroy
      @playlist_song.destroy
      head :no_content
    end

    private

    def playlist_song_params
      params.permit(:playlist_id, :song_id)
    end

    def set_playlist_song
      @playlist_song = PlaylistSong.find(params[:id]) if params[:id]
    end
  end
end
