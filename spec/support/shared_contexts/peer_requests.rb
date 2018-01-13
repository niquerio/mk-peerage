require "rails_helper"

shared_examples_for "a peerage" do |peerage, other_peerage|
  #it_behaves_like "the outside world's view of a peerage", peerage

  #it_behaves_like "post /chambers/PEERAGE/admin/candidates", peerage
  #it_behaves_like "delete /chambers/PEERAGE/admin/candidates/:id", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/candidates/:id/edit", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/candidates", peerage, other_peerage
  #it_behaves_like "put /chambers/PEERAGE/admin/candidates/:id", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/candidates/new", peerage, other_peerage

  #it_behaves_like "get /chambers/PEERAGE/admin/PEERS/new", peerage, other_peerage
  #it_behaves_like "post /chambers/PEERAGE/admin/PEERS", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/PEERS/:id/edit", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/PEERS", peerage, other_peerage
  #it_behaves_like "put /chambers/PEERAGE/admin/PEERS/:id", peerage, other_peerage

  #it_behaves_like "post /chambers/PEERAGE/admin/poll", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/poll/edit", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/admin/poll/new", peerage, other_peerage
  #it_behaves_like "put /chambers/PEERAGE/admin/poll", peerage, other_peerage

  #it_behaves_like "get /chambers/PEERAGE/candidates/:id", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/candidates/:id/poll_comments", peerage, other_peerage
  #it_behaves_like "get /chambers/PEERAGE/candidates", peerage, other_peerage

  it_behaves_like "get /chambers/PEERAGE/groups/:slug", peerage, other_peerage
  it_behaves_like "get /chambers/PEERAGE/groups", peerage, other_peerage
end

