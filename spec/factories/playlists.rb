FactoryGirl.define do
  factory :playlist do
    name { Faker::Music.chord }
  end
end