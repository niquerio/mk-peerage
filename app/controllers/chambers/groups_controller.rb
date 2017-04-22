module Chambers
  class GroupsController < ApplicationController
    before_action :authenticate_user!
    def index
      @middle_kingdom = Group.find_by(name: 'the Middle')
    end
    def show
      name = params[:name].tr("_"," ")
      @group = Group.find_by(name: name)
    end
  end
end