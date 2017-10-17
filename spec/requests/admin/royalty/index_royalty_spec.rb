require "rails_helper"
describe "Get /chambers/admin/royalty" do
  it "shows list of candidates if admin user" do
    admin = create(:admin)
    sign_in(admin)
    get "/chambers/admin/royalty"
    expect(response).to have_http_status(:success)
    expect(response.body).to include('Manage Royalty')
  end
  it "shows royalty bolded" do
    admin = create(:admin)
    royalty = create(:user, sca_name: 'Duke Ducky', royalty: true, laurel: false)
    sign_in(admin)
    get "/chambers/admin/royalty"
    expect(response.body).not_to include('<strong>Default Laurel</strong>')
    expect(response.body).to include('Duke Ducky')
  end 
  it "shows does not show inactive users" do
    admin = create(:admin)
    royalty = create(:royal)
    inactive_laurel = create(:user, sca_name: 'Inactive Laurel', active: false)
    sign_in(admin)
    get "/chambers/admin/royalty"
    expect(response.body).not_to include('Inactive Laurel')
  end 
  it "redirects if not logged in" do
    get "/chambers/admin/royalty"
    expect(response).to have_http_status(:found)
    expect(response.body).to include('redirected')
  end
  it "rasies AccessDenied Error if user is not an admin" do
    peer = create(:user)
    sign_in(peer)
    expect{get "/chambers/admin/royalty"}.to raise_error(CanCan::AccessDenied)
  end
end
