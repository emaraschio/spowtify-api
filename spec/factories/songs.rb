FactoryGirl.define do
  factory :song do
    name { Faker::Music.instrument }
    duration { Faker::Number.number }
    genre { 'rock' }
    artist_id nil
    album_id nil
  end
end