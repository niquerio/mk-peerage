require 'rails_helper'
require 'results_calculator'
describe "calculate" do
  before(:each) do
    @candidate = create(:candidate)
  end
  it "calculates data for saved advisings" do
    laurel_poll = create(:past_poll, published: false)
    pelican_poll = create(:past_poll, published: false, peerage_type: :pelican)
    lc = create(:laurel_candidate)
    pc = create(:pelican_candidate)
    laurel_advising = create(:advising, poll: laurel_poll, candidate: lc)
    pelican_advising = create(:advising, poll: pelican_poll, candidate: pc)
    ResultsCalculator.new(laurel_poll).calculate
    expect(PollResult.count).to eq(1)
  end
  it "does not create PollResults for if Poll results already exist" do
    p = create(:past_poll)
    c = create(:candidate)
    poll_result = create(:poll_result, poll: p, candidate: c)    
    expect(PollResult.count).to eq(1)
    ResultsCalculator.new(p).calculate
    expect(PollResult.count).to eq(1)
  end


  it "does not create Poll Results for current poll" do
      current_poll = create(:current_poll)
      laurel = create(:laurel_peer)

      @advising = create(:advising, candidate: @candidate, peer: laurel, poll: current_poll, judgement: :elevate) 
      expect{ResultsCalculator.new(current_poll).calculate}.to raise_error(ArgumentError)
  end

  it "does not create Poll Results for future poll" do
      future = create(:future_poll)
      laurel = create(:laurel_peer)

      #this is advising isn't possible anyway)
      create(:advising, candidate: @candidate, peer: laurel, poll: future, judgement: :elevate) 
      expect{ResultsCalculator.new(future).calculate}.to raise_error(ArgumentError)
  end

  context "past poll" do
    before(:each) do
      @past_poll = create(:past_poll, published: false)
      @laurel1 = create(:laurel_peer)
      @laurel2 = create(:laurel_peer)
      @laurel3 = create(:laurel_peer)
      @laurel4 = create(:laurel_peer)
      @laurel5 = create(:laurel_peer)
      @advising1 = build(:advising, candidate: @candidate, peer: @laurel1, poll: @past_poll) 
      @advising2 = build(:advising, candidate: @candidate, peer: @laurel2, poll: @past_poll) 
      @advising3 = build(:advising, candidate: @candidate, peer: @laurel3, poll: @past_poll) 
      @advising4 = build(:advising, candidate: @candidate, peer: @laurel4, poll: @past_poll) 
      @advising5 = build(:advising, candidate: @candidate, peer: @laurel5, poll: @past_poll) 
      
    end

    it "creates PollResult for candidates" do
      expect(PollResult.count).to eq(0)
      @advising1.save
      ResultsCalculator.new(@past_poll).calculate
      expect(PollResult.count).to eq(1)
    end
    it "updates PollResults if new results are in" do
      @advising1.judgement = :elevate 
      @advising1.save
      ResultsCalculator.new(@past_poll).calculate
      expect(PollResult.count).to eq(1)
      expect(PollResult.first.elevate).to eq(1)
      @advising2.judgement = :elevate 
      @advising2.save
      ResultsCalculator.new(Poll.first).calculate
      expect(PollResult.count).to eq(1)
      expect(PollResult.first.elevate).to eq(2)
    end
    it "creates poll results for past poll even when there's a scheduled poll" do
      future = create(:poll, start_date: DateTime.now + 1.days, end_date: DateTime.now + 2.day)
      @advising1.save
      ResultsCalculator.new(@past_poll).calculate
      expect(PollResult.count).to eq(1)
      
    end
    it "computes result calculations for given candidate" do
      @advising1.judgement = :elevate
      @advising1.save
      @advising2.judgement = :elevate
      @advising2.save

      ResultsCalculator.new(@past_poll).calculate
      result = PollResult.last
      expect(result.elevate).to eq(2)
      expect(result.drop).to eq(0)
      expect(result.wait).to eq(0)
      expect(result.no_strong_opinion).to eq(0)
    end

    it "computes calculations for multiple candidates" do
      @advising1.judgement = :wait
      @advising1.save
      
      candidate2 = create(:candidate)
      @advising2.candidate = candidate2
      @advising2.judgement = :elevate
      @advising2.save

      ResultsCalculator.new(@past_poll).calculate
      expect(PollResult.count).to eq(2)
      expect(PollResult.find_by(candidate: @candidate).wait).to eq(1)
      expect(PollResult.find_by(candidate: @candidate).elevate).to eq(0)

      expect(PollResult.find_by(candidate: candidate2).wait).to eq(0)
      expect(PollResult.find_by(candidate: candidate2).elevate).to eq(1)
    end

    it "handles candidate with no advisings" do
      ResultsCalculator.new(@past_poll).calculate
      expect(PollResult.count).to be(0) 
    end
    it "handles candidate with incomplete advisings" do
      cand = create(:laurel_candidate)
      @advising1.judgement = :wait
      @advising1.save

      create(:advising, candidate: cand, peer: @laurel2, poll: @past_poll, judgement: :wait) 
      create(:advising, candidate: cand, peer: @laurel3, poll: @past_poll, judgement: :elevate) 
      create(:advising, candidate: cand, peer: @laurel4, poll: @past_poll, judgement: :no_strong_opinion) 
      ResultsCalculator.new(@past_poll).calculate
      pr = PollResult.find_by(candidate: cand)
      expect(pr.no_response).to eq(1)
      expect(pr.wait).to eq(1)
      expect(pr.elevate).to eq(1)
      expect(pr.no_strong_opinion).to eq(1)
      expect(pr.drop).to eq(0)
      expect(pr.rec).to eq(0.5)
      expect(pr.fav).to eq(0.25)
    end
  end
  
end
