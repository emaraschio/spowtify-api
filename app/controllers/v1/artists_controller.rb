module V1
  class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]

    # GET /artists
    def index
      @artists = current_user.artists.all
      json_response(@artists)
    end

    # POST /artists
    def create
      @artist = current_user.artists.create!(artist_params)
      json_response(@artist, :created)
    end

    # GET /artists/:id
    def show
      json_response(@artist)
    end

    # PUT /artists/:id
    def update
      @artist.update(artist_params)
      head :no_content
    end

    # DELETE /artists/:id
    def destroy
      @artist.destroy
      head :no_content
    end

    private

    def artist_params
      params.permit(:name, :bio, :genre_type)
    end

    def set_artist
      @artist = Artist.find(params[:id])
    end
  end
end
