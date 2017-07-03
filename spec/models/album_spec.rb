require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should belong_to(:artist) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:art) }
  it { should validate_presence_of(:abstract) }
end
