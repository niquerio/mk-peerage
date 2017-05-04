class ResultsCalculator
  def calculate
    poll = Poll.last
    if !PollResult.exists?(poll: poll) and poll.end_date < DateTime.now
      
        wait = Judgement.find_by(name:'Wait')
        no_strong_opinion = Judgement.find_by(name:'No Strong Opinion')
        elevate = Judgement.find_by(name:'Elevate')
        drop = Judgement.find_by(name:'Drop')
      Candidate.all.each do |cand|
        advisings = Advising.where('poll_id = ? AND candidate_id = ? AND submitted = ?',poll.id, cand.id, true)
        unless advisings.empty?  
          PollResult.create do |pr|
            pr.elevate = advisings.where(judgement: elevate).count
            pr.drop = advisings.where(judgement: drop).count
            pr.no_strong_opinion = advisings.where(judgement: no_strong_opinion).count
            pr.wait = advisings.where(judgement: wait).count
            pr.rec = (pr.elevate + pr.drop + pr.wait)/advisings.count
            pr.fav = (pr.elevate - pr.drop)/advisings.count

            pr.candidate = cand
            pr.poll = poll
          end
        end
      end    
    end
  end
end
