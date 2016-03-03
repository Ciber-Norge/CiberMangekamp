class Season < ActiveRecord::Base
  has_many :events

  def generate_leaderboard_correct
    leaderboard = {}

    # retrieve all results
    events = Event.where("season_id = '#{self.id}'")
    events.each do | event |
      # don't add events with no results
      next if event.results.empty?

      participants = Participant.where('event_id = ?', event.id)
      participants.each do | participant |
        user = User.find(participant.user_id)
        leaderboard[user.id] ||= {}
        leaderboard[user.id][:name] = user.name
        leaderboard[user.id][:results] ||= {}
        leaderboard[user.id][:results][event.id] = {
          :event_id => event.id,
          :event_title => event.title,
          :rank => participant.result.rank
        }
      end
    end

    # if they have more then 8 events, remove the bad ones
    # TODO

    # if missing one of the main categories, add fake points
    # TODO: Add categories to events...

    # if less then 8, add fake points
    leaderboard.each do | key, value |
      size = value[:results].size
      if size < 8
        value[:results][0] = {
          :event_id => 0,
          :event_title => 'Missing events',
          :rank => (8 - size) * 99
        }
      end
    end

    # sum all scores
    leaderboard.each do | key, value |
      value[:score] = value[:results].sum { |key, result| result[:rank] }
    end

    # get users with this season
    # get the best score for each category
    ## if missing one, add one with last points
    # get the rest of the best score
    ## is missing some, add scores with last points
    leaderboard.sort_by {|key, value| value[:score] }
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
