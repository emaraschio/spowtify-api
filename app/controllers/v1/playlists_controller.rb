module V1
  class PlaylistsController < ApplicationController
    before_action :set_playlist, only: [:show, :update, :destroy]

    # GET /playlists
    def index
      @playlists = current_user.playlists
      json_response(@playlists)
    end

    # POST /playlists
    def create
      @playlist = current_user.playlists.create!(playlist_params)
      json_response(@playlist, :created)
    end

    # GET /playlists/:id
    def show
      json_response(@playlist)
    end

    # PUT /playlists/:id
    def update
      @playlist.update(playlist_params)
      head :no_content
    end

    # DELETE /playlists/:id
    def destroy
      @playlist.destroy
      head :no_content
    end

    private

    def playlist_params
      params.permit(:name)
    end

    def set_playlist
      @playlist = Playlist.find(params[:id])
    end
  end
end
