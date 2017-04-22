require "rails_helper"
describe "Get /chambers/candidates/sca_name/edit" do
  it "shows edit page for laurel" do
    laurel = create(:user, sca_name: 'Mundugus Jones', role: 'admin')
    sign_in(laurel)
    candidate = create(:candidate, sca_name: 'Dingus McDOOOGLE')
    get "/chambers/candidates/#{candidate.id}/edit"
    expect(response).to have_http_status(:success)
    expect(response.body).to include('Edit Candidate Dingus McDOOOGLE')
  end
  it "redirects if not logged in" do
    candidate = create(:candidate, sca_name: 'Dingus McDOOOGLE')
    get "/chambers/candidates/#{candidate.id}/edit"
    expect(response).to have_http_status(:found)
    expect(response.body).to include('redirected')
  end
end
