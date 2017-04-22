require "rails_helper"
describe "Get /chambers/manage_candidates" do
  it "shows list of candidates if admin user" do
    laurel = create(:user, role: :admin)
    sign_in(laurel)
    get "/chambers/manage_candidates"
    expect(response).to have_http_status(:success)
    expect(response.body).to include('Manage Candidates')
  end
  it "redirects if not logged in" do
    get "/chambers/manage_candidates"
    expect(response).to have_http_status(:found)
    expect(response.body).to include('redirected')
  end
  it "rasies AccessDenied Error if user is not an admin" do
    laurel = create(:user, role: :normal)
    sign_in(laurel)
    expect{get "/chambers/manage_candidates"}.to raise_error(CanCan::AccessDenied)
  end
end
