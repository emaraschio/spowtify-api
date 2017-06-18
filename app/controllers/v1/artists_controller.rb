module V1
  class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]
    swagger_controller :users, "Artists Management"

    swagger_api :index do |api|
      summary "Get all artists"
      response :ok
    end
    # GET /artists
    def index
      @artists = current_user.artists.all
      json_response(@artists)
    end

    swagger_api :create do |api|
      summary "create an artist"
      notes "Make sure you pass parameters in artists' hash:"
      ArtistsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /artists
    def create
      @artist = current_user.artists.create!(artist_params)
      json_response(@artist, :created)
    end

    swagger_api :show do
      summary "Get an artist"
      param :path, :id, :integer, :required, "ID of an Artist"
      response :ok
      response :not_found
    end
    # GET /artists/:id
    def show
      json_response(@artist)
    end

    swagger_api :update do |api|
      summary "update artist"
      notes "Make sure you pass parameters in artists' hash:"
      param :path, :id, :integer, :required, "ID of an Artist"
      ArtistsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # PUT /artists/:id
    def update
      @artist.update(artist_params)
      head :no_content
    end

    swagger_api :destroy do
      summary "Delete an artist"
      notes "Delete an artist by passing his id"
      param :path, :id, :integer, :required, "ID of an Artist"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /artists/:id
    def destroy
      @artist.destroy
      head :no_content
    end

    private

    def self.add_common_params(api) 
      api.param :form, "name", :string, :required, "Name"
      api.param :form, "genre_type", :string, :required, "Genre Type"
      api.param :form, "bio", :string, :required, "Bio"
    end

    def artist_params
      params.permit(:name, :bio, :genre_type)
    end

    def set_artist
      @artist = Artist.find(params[:id])
    end
  end
end
