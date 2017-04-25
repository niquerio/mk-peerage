require "rails_helper"
describe "Get /" do
  it "shows laurel page" do
    laurel = create(:user, sca_name: 'Mundungus Smith')
    get "/laurels/mundungus_smith"
    expect(response).to have_http_status(:success)
    expect(response.body).to include('Mundungus Smith')
  end
end