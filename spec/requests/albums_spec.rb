require 'rails_helper'

RSpec.describe 'Albums API' do

  let!(:artist) { create(:artist) }
  let!(:albums) { create_list(:album, 5, artist_id: artist.id) }
  let(:artist_id) { artist.id }
  let(:id) { albums.first.id }

  describe 'GET /artists/:artist_id/albums' do
    before { get "/artists/#{artist_id}/albums" }

    context 'when artist exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all artist albums' do
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

  describe 'GET /artists/:artist_id/albums/:id' do
    before { get "/artists/#{artist_id}/albums/#{id}" }

    context 'when artist album exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the album' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when artist album does not exist' do
      let(:id) { 323 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Album/)
      end
    end
  end

  describe 'POST /artists/:artist_id/albums' do
    let(:valid_attributes) { { name: 'Nevermind', art: 'A legendary', abstract: 'Best of the best' } }

    context 'when request attributes are valid' do
      before { post "/artists/#{artist_id}/albums", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/artists/#{artist_id}/albums", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /artists/:artist_id/albums/:id' do
    let(:valid_attributes) { { name: 'Bleach' } }

    before { put "/artists/#{artist_id}/albums/#{id}", params: valid_attributes }

    context 'when album exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the album' do
        updated_album = Album.find(id)
        expect(updated_album.name).to match(/Bleach/)
      end
    end

    context 'when the album does not exist' do
      let(:id) { 194 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Album/)
      end
    end
  end

  describe 'DELETE /artists/:id' do
    before { delete "/artists/#{artist_id}/albums/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end