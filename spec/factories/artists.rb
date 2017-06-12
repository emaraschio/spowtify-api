FactoryGirl.define do
  factory :artist do
    name { Faker::RockBand.name }
    bio { Faker::Lorem.sentence }
    genre_type { 'band' }
    user_id nil
  end
end