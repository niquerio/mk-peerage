class GroupsController < ApplicationController
  def index
    @kingdoms = Group.roots
    render template: "peerage/groups/index"
  end
  def show
    @group = Group.find_by(slug: params[:slug])
    render template: "peerage/groups/show"
  end
  def peerage_type
    raise "Don't do this"
  end
end
