require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should validate_presence_of(:name) }
end
