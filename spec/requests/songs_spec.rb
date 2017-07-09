require 'rails_helper'

RSpec.describe 'Songs API' do

  let!(:album) { create(:album) }
  let!(:songs) { create_list(:song, 5, album_id: album.id) }
  let(:album_id) { album.id }
  let(:id) { songs.first.id }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe 'GET /albums/:album_id/songs' do
    before { get "/albums/#{album_id}/songs", headers: headers }

    context 'when album exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all album songs' do
        expect(json.size).to eq(5)
      end
    end

    context 'when album does not exist' do
      let(:album_id) { 44 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Album/)
      end
    end
  end

  describe 'GET /albums/:album_id/songs/:id' do
    before { get "/albums/#{album_id}/songs/#{id}", headers: headers }

    context 'when album song exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the song' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when album song does not exist' do
      let(:id) { 323 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Song/)
      end
    end
  end

  describe 'POST /albums/:album_id/songs' do
    let(:valid_attributes) { { name: 'In bloom', duration: '2', genre: 'Garage Rock', album_id: album_id }.to_json }

    context 'when request attributes are valid' do
      before { post "/albums/#{album_id}/songs", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/albums/#{album_id}/songs", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank, Duration can't be blank, Genre can't be blank/)
      end
    end
  end

  describe 'PUT /albums/:album_id/songs/:id' do
    let(:valid_attributes) { { name: 'Polly' }.to_json }

    before { put "/albums/#{album_id}/songs/#{id}", params: valid_attributes, headers: headers }

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

  describe 'DELETE /albums/:id' do
    before { delete "/albums/#{album_id}/songs/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end