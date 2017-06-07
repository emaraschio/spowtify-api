FactoryGirl.define do
  factory :artist do
    name { Faker::RockBand.name }
    bio { Faker::Lorem.sentence }
    type { 'band' }
  end
end