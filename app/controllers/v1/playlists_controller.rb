module V1
  class PlaylistsController < ApplicationController
    before_action :set_playlist, only: [:show, :update, :destroy]
    swagger_controller :users, "Playlists Management"

    swagger_api :index do |api|
      summary "Get all playlists"
      response :ok
    end
    # GET /playlists
    def index
      @playlists = current_user.playlists
      json_response(@playlists)
    end

    swagger_api :create do |api|
      summary "create a playlist"
      notes "Make sure you pass parameters in playlists' hash:"
      PlaylistsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end
    # POST /playlists
    def create
      @playlist = current_user.playlists.create!(playlist_params)
      json_response(@playlist, :created)
    end

    swagger_api :show do
      summary "Get a playlist"
      param :path, :id, :integer, :required, "ID of Playlist"
      response :ok
      response :not_found
    end
    # GET /playlists/:id
    def show
      json_response(@playlist)
    end

    swagger_api :update do |api|
      summary "update playlist"
      notes "Make sure you pass parameters in playlists' hash:"
      param :path, :id, :integer, :required, "ID of Playlist"
      PlaylistsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # PUT /playlists/:id
    def update
      @playlist.update(playlist_params)
      head :no_content
    end

    swagger_api :destroy do
      summary "Delete Playlist"
      notes "Delete a playlist by passing his id"
      param :path, :id, :integer, :required, "ID of Playlist"
      response :ok
      response :unprocessable_entity
      response :not_found
    end
    # DELETE /playlists/:id
    def destroy
      @playlist.destroy
      head :no_content
    end

    private

    def self.add_common_params(api) 
      api.param :form, "name", :string, :required, "Name"
    end

    def playlist_params
      params.permit(:name)
    end

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end
  end
end
