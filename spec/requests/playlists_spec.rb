require 'rails_helper'

RSpec.describe 'Playlists API', type: :request do

  let!(:playlists) { create_list(:playlist, 10) }
  let(:playlist_id) { playlists.first.id }

  describe 'GET /playlists' do
    before { get '/playlists' }

    it 'returns playlists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /playlists/:id' do
    before { get "/playlists/#{playlist_id}" }

    context 'when the record exists' do
      it 'returns the playlist' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(playlist_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:playlist_id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Playlist/)
      end
    end
  end

  describe 'POST /playlists' do
    let(:valid_attributes) { { name: 'Summer 2017' } }

    context 'when request is valid' do
      before { post '/playlists', params: valid_attributes }

      it 'creates an playlist' do
        expect(json['name']).to eq('Summer 2017')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /playlists/:id' do
    let(:valid_attributes) { { name: 'Post Rock best songs' }.to_json }

    context 'when the record exists' do
      before { put "/playlists/#{playlist_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /playlists/:id' do
    before { delete "/playlists/#{playlist_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
