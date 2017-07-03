module V1
  class SongsController < ApplicationController
    before_action :set_artist
    before_action :set_song, only: [:show, :update, :destroy]
    swagger_controller :users, "Songs Management"

    swagger_api :index do |api|
      summary "Get all songs from an artist"
      param :path, :artist_id, :integer, :required, "ID of artist"
      response :ok
    end
    # GET /artists/:artist_id/song
    def index
      json_response(@artist.songs)
    end

    swagger_api :show do
      summary "Get an song"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of a Song"
      response :ok
      response :not_found
    end
    # GET /artists/:artist_id/songs/:id
    def show
      json_response(@song)
    end

    swagger_api :create do |api|
      summary "create an song"
      notes "Make sure you pass parameters in songs' hash:"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      SongsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /artists/:artist_id/songs
    def create
      @artist.songs.create!(song_params)
      json_response(@artist, :created)
    end

    swagger_api :update do |api|
      summary "update song"
      notes "Make sure you pass parameters in songs' hash:"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of a Song"
      SongsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # PUT /artists/:artist_id/songs/:id
    def update
      @song.update(song_params)
      head :no_content
    end

    swagger_api :destroy do
      summary "Delete an song"
      notes "Delete an song by passing his id"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of a Song"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /artists/:artist_id/songs/:id
    def destroy
      @song.destroy
      head :no_content
    end

    private

    def self.add_common_params(api) 
      api.param :form, "name", :string, :required, "Name"
      api.param :form, "duration", :time, :required, "Duration"
      api.param :form, "genre", :string, :required, "Genre"
    end

    def song_params
      params.permit(:name, :duration, :abstract, :album_id, :genre, 
                    :description, :image_url, :featured)
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    def set_song
      @song = @artist.songs.find_by!(id: params[:id]) if @artist
    end
  end
end
