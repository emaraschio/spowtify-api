require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should have_many(:songs).dependent(:destroy) }
  it { should have_many(:albums).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:bio) }
  it { should validate_presence_of(:type) }
end