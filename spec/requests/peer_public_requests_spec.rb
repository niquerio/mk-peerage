require "rails_helper"
describe "outside world's view of peerage" do

  describe "Get /laurel/LAUREL_NAME/contact" do
      it "shows contact page for given laurel" do
          peer = create(:laurel_user, sca_name: "Mundungus Smith")
          get "/laurel/mundungus_smith/contact"
          expect(response).to have_http_status(:success)
          expect(response.body).to include("Contact Mundungus Smith")
      end
  end

  describe "Get /laurel/groups" do
      it "shows list of groups and link to specific group" do
          group = create(:group, name: "High Haven", slug: "high_haven")
          create(:laurel_user, group: group)
          get "/laurel/groups"
          expect(response).to have_http_status(:success)
          expect(response.body).to include("/groups/high_haven")
      end
      it "renders tree of groups" do
          group = create(:group, name: "High Haven", slug: "high_haven")
          child = create(:group, name: "The Barrows", slug: "the_barrows", parent_id: group.id)
          grand_child = create(:group, name: "Poopland", slug: "poopland", parent_id: child.id)
          create(:laurel_user, group: grand_child)
          get "/laurel/groups"
          expect(response.body).to include("/groups/high_haven")
          expect(response.body).to include("/groups/the_barrows")
          expect(response.body).to include("/groups/poopland")
      end
  end

  describe "Get /laurel/groups" do
      it "shows list of groups and link to specific group" do
          group = create(:group, name: "High Haven", slug: "high_haven")
          peer = create(:laurel_user, group: group)
          get "/laurel/groups/high_haven"
          expect(response).to have_http_status(:success)
          expect(response.body).to include(peer.sca_name)
      end
      it "does not show non-laurels" do
          group = create(:group, name: "High Haven", slug: "high_haven")
          royal = create(:royal, group: group)
          get "/laurel/groups/high_haven"
          expect(response).to have_http_status(:success)
          expect(response.body).not_to include(royal.sca_name)
      end
      it "shows list of child groups" do
          group = create(:group, name: "High Haven", slug: "high_haven")
          child = create(:group, name: "The Barrows", slug: "the_barrows", parent_id: group.id)
          grand_child = create(:group, name: "Poopland", slug: "poopland", parent_id: child.id)
          create(:laurel_user, group: grand_child)
          get "/laurel/groups/high_haven"
          expect(response.body).not_to include("/laurel/groups/high_haven")
          expect(response.body).to include("/laurel/groups/the_barrows")
          expect(response.body).to include("/laurel/groups/poopland")
      end
  end

  describe "Get /laurel/roll_of_honor" do
      it "shows list of laurel" do
          get "/laurel/roll_of_honor"
          expect(response).to have_http_status(:success)
          expect(response.body).to include("Roll of Honor")
      end
      it "only shows laurel (not royalty)" do
          create(:laurel_user, sca_name: "Mistress Mindy")
          create(:royal, sca_name: "Duke Ducky")
          get "/laurel/roll_of_honor"
          expect(response.body).to include("Mistress Mindy")
          expect(response.body).not_to include("Duke Ducky")
      end
  end

  describe "Get /laurel/LAUREL_NAME" do
      it "shows laurel page" do
          create(:laurel_user, sca_name: "Mundungus Smith")
          get "/laurel/mundungus_smith"
          expect(response).to have_http_status(:success)
          expect(response.body).to include("Mundungus Smith")
      end
  end
end
