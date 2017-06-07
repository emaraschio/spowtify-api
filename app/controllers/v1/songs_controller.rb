module V1
  class SongsController < ApplicationController
    before_action :set_artist
    before_action :set_song, only: [:show, :update, :destroy]

    # GET /artists/:artist_id/song
    def index
      json_response(@artist.songs)
    end

    # GET /artists/:artist_id/songs/:id
    def show
      json_response(@song)
    end

    # POST /artists/:artist_id/songs
    def create
      @artist.songs.create!(song_params)
      json_response(@artist, :created)
    end

    # PUT /artists/:artist_id/songs/:id
    def update
      @song.update(song_params)
      head :no_content
    end

    # DELETE /artists/:artist_id/songs/:id
    def destroy
      @song.destroy
      head :no_content
    end

    private

    def song_params
      params.permit(:name, :duration, :abstract, :album_id, :genre)
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    def set_song
      @song = @artist.songs.find_by!(id: params[:id]) if @artist
    end
  end
end
