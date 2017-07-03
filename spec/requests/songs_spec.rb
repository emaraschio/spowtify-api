require 'rails_helper'

RSpec.describe 'Songs API' do

  let!(:album) { create(:album) }
  let!(:songs) { create_list(:song, 5, artist_id: album.artist.id, album_id: album.id) }
  let(:artist_id) { album.artist.id }
  let(:album_id) { album.id }
  let(:id) { songs.first.id }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe 'GET /artists/:artist_id/songs' do
    before { get "/artists/#{artist_id}/songs", headers: headers }

    context 'when artist exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all artist songs' do
        expect(json.size).to eq(5)
      end
    end

    context 'when artist does not exist' do
      let(:artist_id) { 44 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Artist/)
      end
    end
  end

  describe 'GET /artists/:artist_id/songs/:id' do
    before { get "/artists/#{artist_id}/songs/#{id}", headers: headers }

    context 'when artist song exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the song' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when artist song does not exist' do
      let(:id) { 323 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Song/)
      end
    end
  end

  describe 'POST /artists/:artist_id/songs' do
    let(:valid_attributes) { { name: 'In bloom', duration: '2', genre: 'Garage Rock', album_id: album_id }.to_json }

    context 'when request attributes are valid' do
      before { post "/artists/#{artist_id}/songs", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/artists/#{artist_id}/songs", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Album must exist, Name can't be blank/)
      end
    end
  end

  describe 'PUT /artists/:artist_id/songs/:id' do
    let(:valid_attributes) { { name: 'Polly' }.to_json }

    before { put "/artists/#{artist_id}/songs/#{id}", params: valid_attributes, headers: headers }

    context 'when song exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the song' do
        updated_song = Song.find(id)
        expect(updated_song.name).to match(/Polly/)
      end
    end

    context 'when the song does not exist' do
      let(:id) { 194 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Song/)
      end
    end
  end

  describe 'DELETE /artists/:id' do
    before { delete "/artists/#{artist_id}/songs/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end