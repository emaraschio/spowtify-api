require 'rails_helper'

FactoryGirl.define do
  factory :album do
    name { Faker::Lorem.word }
    art { Faker::Lorem.sentence }
    abstract { Faker::Hipster.sentence }
    artist { create(:artist) }
  end
end