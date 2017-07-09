module V1
  class SongsController < ApplicationController
    before_action :set_album
    before_action :set_song, only: [:show, :update, :destroy]
    swagger_controller :users, "Songs Management"

    swagger_api :index do |api|
      summary "Get all songs from an album"
      param :path, :album_id, :integer, :required, "ID of Album"
      response :ok
    end
    # GET /albums/:album_id/song
    def index
      json_response(@album.songs)
    end

    swagger_api :show do
      summary "Get an song"
      param :path, :album_id, :integer, :required, "ID of an Album"
      param :path, :id, :integer, :required, "ID of a Song"
      response :ok
      response :not_found
    end
    # GET /albums/:album_id/songs/:id
    def show
      json_response(@song)
    end

    swagger_api :create do |api|
      summary "create an song"
      notes "Make sure you pass parameters in songs' hash:"
      param :path, :album_id, :integer, :required, "ID of an Album"
      SongsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /albums/:album_id/songs
    def create
      @album.songs.create!(song_params)
      json_response(@album, :created)
    end

    swagger_api :update do |api|
      summary "update song"
      notes "Make sure you pass parameters in songs' hash:"
      param :path, :album_id, :integer, :required, "ID of an Album"
      param :path, :id, :integer, :required, "ID of a Song"
      SongsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # PUT /albums/:album_id/songs/:id
    def update
      @song.update(song_params)
      head :no_content
    end

    swagger_api :destroy do
      summary "Delete an song"
      notes "Delete an song by passing his id"
      param :path, :album_id, :integer, :required, "ID of an Album"
      param :path, :id, :integer, :required, "ID of a Song"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /albums/:album_id/songs/:id
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

    def set_album
      @album = Album.find(params[:album_id])
    end

    def set_song
      @song = @album.songs.find_by!(id: params[:id]) if @album
    end
  end
end
