require "rails_helper"
describe "Get /chambers/admin/royalty/new" do
  it "shows form for new user if admin user" do
    admin = create(:admin)
    sign_in(admin)
    get "/chambers/admin/royalty/new"
    expect(response).to have_http_status(:success)
    expect(response.body).to include('Add New Royal')
  end
  it "redirects if not logged in" do
    get "/chambers/admin/royalty/new"
    expect(response).to have_http_status(:found)
    expect(response.body).to include('redirected')
  end
  it "rasies AccessDenied Error if user is not an admin" do
    peer = create(:user)
    sign_in(peer)
    expect{get "/chambers/admin/royalty/new"}.to raise_error(CanCan::AccessDenied)
  end
end