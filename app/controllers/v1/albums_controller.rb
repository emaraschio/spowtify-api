module V1
  class AlbumsController < ApplicationController
    before_action :set_artist
    before_action :set_album, only: [:show, :update, :destroy]
    swagger_controller :users, "Albums Management"

    swagger_api :index do |api|
      summary "Get all albums from an artist"
      param :path, :artist_id, :integer, :required, "ID of artist"
      response :ok
    end
    # GET /artists/:artist_id/albums
    def index
      json_response(@artist.albums)
    end

    swagger_api :show do
      summary "Get an album"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of an Album"
      response :ok
      response :not_found
    end
    # GET /artists/:artist_id/albums/:id
    def show
      json_response(@album)
    end

    swagger_api :create do |api|
      summary "create an album"
      notes "Make sure you pass parameters in albums' hash:"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      AlbumsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /artists/:artist_id/albums
    def create
      @artist.albums.create!(album_params)
      json_response(@artist, :created)
    end

    swagger_api :update do |api|
      summary "update album"
      notes "Make sure you pass parameters in albums' hash:"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of an Album"
      AlbumsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # PUT /artists/:artist_id/albums/:id
    def update
      @album.update(album_params)
      head :no_content
    end

    swagger_api :destroy do
      summary "Delete an album"
      notes "Delete an album by passing his id"
      param :path, :artist_id, :integer, :required, "ID of an Artist"
      param :path, :id, :integer, :required, "ID of an Album"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /artists/:artist_id/albums/:id
    def destroy
      @album.destroy
      head :no_content
    end

    private

    def self.add_common_params(api) 
      api.param :form, "name", :string, :required, "Name"
      api.param :form, "art", :string, :required, "Art"
      api.param :form, "abstract", :string, :required, "Abstract"
    end

    def album_params
      params.permit(:name, :art, :abstract)
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    def set_album
      @album = @artist.albums.find_by!(id: params[:id]) if @artist
    end
  end
end
