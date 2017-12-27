class Chambers::Pelican::Admin::PollsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  helper_method :peerage
  def new
    @poll = Poll.new
  end

  def edit
    @poll = Poll.last_for(:pelican)
    if @poll.end_date < DateTime.now #if last poll has already ended
      redirect_to chambers_path
    end
  end

  def create
    @poll = Poll.new(poll_params)
    @poll.peerage_type = :pelican
    @poll.end_date = @poll.end_date + 23.hours + 59.minutes + 59.seconds unless @poll.end_date.nil?
    if @poll.save
      redirect_to chambers_path
    else
      render :new
    end 
  end

  def update
    @poll = Poll.last_for(:pelican)
    @poll.assign_attributes(poll_params)
    @poll.end_date = @poll.end_date + 23.hours + 59.minutes + 59.seconds unless @poll.end_date.nil?
    if @poll.save
      redirect_to chambers_path
    else
      render :edit
    end
  end
  private
  def poll_params
    params.require(:poll).permit(:start_date, :end_date)
  end
  def authorize_admin
    authorize! :manage, :pelican
  end
  def peerage
    :pelican
  end
  def self.controller_path
    'chambers/peerage/admin/polls'
  end
end
