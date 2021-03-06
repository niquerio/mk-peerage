require 'rails_helper'
describe "get /chambers/laurel/candidates" do
  context "signed in laurel" do
    before(:each) do
      @peer = create(:laurel_peer)
      sign_in(@peer.user)
      @candidate = create(:candidate, peerage_type: :laurel, vote: true)
      
    end
    it "shows list of candidates" do
      get "/chambers/laurel/candidates"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Candidates")
    end
    it "has link to candidate's page" do
      get "/chambers/laurel/candidates"
      expect(response.body).to include("/chambers/laurel/candidates/#{@candidate.id}")
    end
    it "shows advocates for given candidate" do
      advocate = create(:laurel_user, sca_name: "Molly Mindingus")
      create(:advocacy, candidate: @candidate, peer: advocate.laurel)
      get "/chambers/laurel/candidates"
      expect(response.body).to include("Molly Mindingus")
    end
    it "shows specialties for laurel candidates" do
      get "/chambers/laurel/candidates"
      expect(response.body).to include("<th>Specialties</th>")
    end

    it "shows results from last poll in table" do
      p = create(:past_published_poll)
      pr = create(:poll_result, candidate: @candidate, poll: p, wait: 123456)
      
      get "/chambers/laurel/candidates"
      expect(response.body).to include("123456")
    end
    it "shows what list the candidate is on" do
      get "/chambers/laurel/candidates"
      expect(response.body).to include("Vote List")
    end

    it "does not show comments from last poll" do
      p = build(:poll, start_date: DateTime.now - 2.days, end_date: DateTime.now - 1.day)
      p.save(validate: false)
      pr = create(:poll_result, candidate: @candidate, poll: p, wait: 123456)
      get "/chambers/laurel/candidates"
      expect(response.body).not_to include("Comments from Last Poll")
      expect(response.body).not_to include("candidates/#{@candidate.id}/poll_comments")
    end
  end

  it "for logged in royal, shows comments from last poll regardless if published" do
      @royal = create(:royal)
      sign_in(@royal)
      @candidate = create(:candidate, peerage_type: :laurel)
      p = create(:past_poll, published: false)
      pr = create(:poll_result, candidate: @candidate, poll: p, wait: 123456)
      get "/chambers/laurel/candidates"
      expect(response.body).to include("Comments from Last Poll")
      expect(response.body).to include("candidates/#{@candidate.id}/poll_comments")
  end

  it "for logged in admin, should not show comments from last poll" do
      @admin = create("laurel_admin".to_sym)
      sign_in(@admin)
      @candidate = create(:candidate, peerage_type: :laurel)
      p = build(:poll, start_date: DateTime.now - 2.days, end_date: DateTime.now - 1.day)
      p.save(validate: false)
      pr = create(:poll_result, candidate: @candidate, poll: p, wait: 123456)
      get "/chambers/laurel/candidates"
      expect(response.body).not_to include("Comments from Last Poll")
      expect(response.body).not_to include("candidates/#{@candidate.id}/poll_comments")
  end
  it "redirects if not logged in" do
    get "/chambers/laurel/candidates"
    expect(response).to have_http_status(:found)
    expect(response.body).to include("redirected")
  end
end
describe "get /chambers/pelican/candidates" do
  context "signed in pelican" do
    before(:each) do
      @peer = create(:pelican_peer)
      sign_in(@peer.user)
      @candidate = create(:candidate, peerage_type: :pelican, vote: true)
      
    end
    it "does not show specialties for pelican candidates" do
      get "/chambers/pelican/candidates"
      expect(response.body).not_to include("<th>Specialties</th>")
    end
  end
end
