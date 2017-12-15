class Chambers::Pelican::CandidatesController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize! :read, :pelican
    @candidates = Candidate.where(peerage_type: :pelican)
    render template: 'chambers/peerage/candidates/index'
  end

  def show
    authorize! :read, :pelican
    @candidate = Candidate.find(params[:id])
    raise "Access Denied" unless @candidate.pelican?
    @pr = @candidate.poll_results.last
    @comment = Comment.new
    @image = Image.new
    render template: 'chambers/peerage/candidates/show'
  end

  def poll_comments
    authorize! :read, PollResult
    @candidate = Candidate.find(params[:id])
    @pr = @candidate.poll_results.last
    unless @pr.nil?
      @advisings = Advising.where("candidate_id = ? AND poll_id = ? AND submitted = true", @candidate.id, @pr.poll_id)
    else
      redirect_to chambers_laurel_candidates_path
    end
  end
end