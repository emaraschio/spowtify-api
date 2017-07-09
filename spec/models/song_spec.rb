require 'rails_helper'

RSpec.describe Song, type: :model do
  it { should belong_to(:album) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:duration) }
  it { should validate_presence_of(:genre) }
end
