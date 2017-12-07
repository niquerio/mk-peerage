require 'rails_helper'
describe 'Get /chambers/groups/High_Haven' do
  it 'shows list of groups and link to specific group' do
    group = create(:group, name: 'High Haven', slug: 'high_haven')
    laurel = create(:user, group: group)
    sign_in(laurel)
    candidate = create(:candidate, group: group, sca_name: 'Dingus McDoooooogle')
    get '/chambers/laurel/groups/high_haven'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(candidate.sca_name)
  end
  it 'shows list of child groups' do
    laurel = create(:user)
    sign_in(laurel)
    group = create(:group, name: 'High Haven', slug: 'high_haven')
    child = create(:group, name: 'The Barrows', slug: 'the_barrows', parent_id: group.id)
    grand_child = create(:group, name: 'Poopland', slug: 'poopland', parent_id: child.id)
    create(:candidate, group: grand_child)
    get '/chambers/laurel/groups/High_Haven'
    expect(response.body).not_to include('/chambers/laurel/groups/high_haven')
    expect(response.body).to include('chambers/laurel/groups/the_barrows')
    expect(response.body).to include('chambers/laurel/groups/poopland')
  end
  context "logged in pelican (non-laurel)" do
    before(:each) do
      @pelican = create(:pelican)
      sign_in(@pelican)
    end
    it "shows not authorized error for non-pelican user" do
      group = create(:group, name: 'High Haven', slug: 'high_haven')
      create(:candidate, group: group)
      expect{get "/chambers/laurel/groups/high_haven"}.to raise_error(CanCan::AccessDenied)
    end
  end
end
