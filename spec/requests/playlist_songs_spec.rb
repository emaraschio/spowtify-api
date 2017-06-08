require 'rails_helper'

RSpec.describe 'Playlist Songs API', type: :request do

  let!(:playlists) { create_list(:playlist, 10) }
  let(:playlist_id) { playlists.first.id }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album, artist_id: artist.id) }
  let!(:songs) { create_list(:song, 5, artist_id: artist.id, album_id: album.id) }
  let(:song_id) { songs.first.id }
  let(:song_name) { songs.first.name }
  let!(:playlist_song) { create(:playlist_song, playlist_id: playlist_id, song_id: song_id) }
  let(:playlist_song_id) { playlist_song.id }

  describe 'POST /playlist_songs' do
    let(:valid_attributes) { { playlist_id: playlist_id, song_id: song_id } }

    context 'when request is valid' do
      before { post '/playlist_songs', params: valid_attributes }

      it 'creates an playlist' do
        expect(json['song_id']).to eq(song_id)
        expect(json['playlist_id']).to eq(playlist_id)
        expect(json['song']['name']).to eq(song_name)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'DELETE /playlist_songs/:id' do
    before { delete "/playlist_songs/#{playlist_song_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
