class Season < ActiveRecord::Base
  has_many :events

  def generate_leaderboard_correct
    # get users with this season
    # get the best score for each category
    ## if missing one, add one with last points
    # get the rest of the best score
    ## is missing some, add scores with last points
  end

  def generate_leaderboard
    leaderboard = {
      :results => {},
      :events => []
    }
    self.events.each do |event|
      event.participants.each do | participant |
        if participant.result
          name = participant.user.name
          leaderboard['results'][name] ||= {}
          leaderboard['results'][name][event.title] = participant.result.rank
        end
      end

      unless event.participant.empty?
        leaderboard['events'] << event.sport
      end
    end

    leaderboard['results'].each do | key, value|
      value[:score] = value.map { |h| h[1] }.sum
    end

    leaderboard['results'] = leaderboard['results'].sort_by {|key, value| value[:score]}
  end
end
