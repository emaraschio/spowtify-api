FactoryGirl.define do
  factory :song do
    name { Faker::Music.instrument }
    duration { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    genre { 'rock' }
    artist_id nil
    album_id nil
    user_id nil
  end
end