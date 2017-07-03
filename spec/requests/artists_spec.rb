require 'rails_helper'

RSpec.describe 'Artists API', type: :request do

  let!(:artists) { create_list(:artist, 10) }
  let(:artist_id) { artists.first.id }
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe 'GET /artists' do
    before { get '/artists', headers: headers }

    it 'returns artists' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /artists/:id' do
    before { get "/artists/#{artist_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the artist' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(artist_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:artist_id) { 11 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Artist/)
      end
    end
  end

  describe 'POST /artists' do
    let(:valid_attributes) { { name: 'Pink Floyd', bio: 'The best band of the world', genre_type: 'band' }.to_json }

    context 'when request is valid' do
      before { post '/artists', params: valid_attributes, headers: headers }

      it 'creates an artist' do
        expect(json['name']).to eq('Pink Floyd')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /artists/:id' do
    let(:valid_attributes) { { name: 'Nirvana' }.to_json }

    context 'when the record exists' do
      before { put "/artists/#{artist_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /artists/:id' do
    before { delete "/artists/#{artist_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
