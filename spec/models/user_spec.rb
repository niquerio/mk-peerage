require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:apprenticeships) }
  it { should have_many(:laurels).through(:apprenticeships) }
  
  it { should have_many(:advocacies) }
  it { should have_many(:candidates).through(:advocacies) }
  it { should have_many(:specializations) }

  it { should have_many(:specialties).through(:specializations) }
  it { should have_many(:comments) }

  it { should belong_to(:group) }
end

RSpec.describe User, 'set_slug' do
  it 'should save slug' do
    user = build(:user, sca_name: 'Heregyð Ketilsdóttir')
    user.save 
    expect(User.last.slug).to eq('heregyd_ketilsdottir')
  end
end
