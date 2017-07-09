FactoryGirl.define do
  factory :song do
    name { Faker::Music.instrument }
    duration { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    genre { 'rock' }
    album_id nil
  end
end