FactoryGirl.define do
  factory :playlist do
    name { Faker::Music.chord }
    user_id nil
  end
end