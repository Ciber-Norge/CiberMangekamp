# coding: utf-8
class Season < ActiveRecord::Base
  has_many :events

  def generate_leaderboard
    events = {}
    participants = {
      :men => {},
      :women => {}
    }
    mangekjempere = {
      :men => {},
      :women => {}
    }

    Event.where("season_id = '#{self.id}'").each do | event |
      # don't add events with no results
      next if event.results.empty?

      # store event
      events[event.id] = {
        :id => event.id,
        :title => event.title,
        :category_id => event.category_id,
        :men => [],
        :women => []
      }
      
      # store participants
      event.participants.each do | participant |
        user = User.find(participant.user_id)

        temp_user = {
          :id => user.id,
          :name => user.name,
          :sex => user.sex,
          :rank => participant.result.rank
        }

        if user.man?
          events[event.id][:men] << temp_user
        else
          events[event.id][:women] << temp_user
        end

        sex = user.man? ? :men : :women
        if participants[sex][user.id]
          participants[sex][user.id][:events][event.id] = {
            :id => event.id,
            :category_id => event.category_id,
            :rank => participant.result.rank
          }
        else
          participants[sex][user.id] = {
            :name => user.name,
            :sex => user.sex,
            :score => 0,
            :results => [],
            :events => {}
          }
          participants[sex][user.id][:events][event.id] = {
            :id => event.id,
            :category_id => event.category_id,
            :rank => participant.result.rank
          }
        end
      end
    end

    # find the mangekjempere
    participants.each do | sex, value |
      mangekjempere[sex] = value.select {|id, participant| participant[:events].size >= 8}
      value.delete_if {|id, participant| participant[:events].size >= 8}
    end

    # remove participants that are not eligble for mangekjemper
    events.each do | id, event |
      event[:men].delete_if {|participant| not mangekjempere[:men].keys.include? participant[:id]}
      event[:women].delete_if {|participant| not mangekjempere[:women].keys.include? participant[:id]}
    end

    # sort the participants for each event
    events.each do | id, event |
      event[:men].sort! {|p1, p2| p1[:rank] <=> p2[:rank]}
      event[:women].sort! {|p1, p2| p1[:rank] <=> p2[:rank]}
    end

    # calculate their new rank
    mangekjempere.each do | sex, value |
      value.each do | id, participant |
        events.each do | e_id, event |
          index = 1
          index_modifier = 0
          last_rank = nil
          event[sex].each do | p |            
            if last_rank
              if last_rank == p[:rank]
                index_modifier += 1
              else
                index += 1
              end
            end

            if p[:id] == id
              new_score = index + (last_rank == p[:rank] ? 0 : index_modifier)
              participant[:events][e_id][:new_rank] = new_score
              break
            end
            
            last_rank = p[:rank]
          end
        end

        # check if category-rule needs to be applied
        results = []
        [1, 2, 3].each do | category_id |
          best = []
          participant[:events].each do | key, event |
            if event[:category_id] == category_id
              best << event[:new_rank]
            end
          end
          if [1, 3].include?(category_id)
            best = best.sort.slice(0, 3)
          else
            best = best.sort
          end
          results << best
        end
        best_results = [results[0].slice!(0), results[1].slice!(0), results[2].slice!(0)]
        results = results.flatten.sort.slice(0, 5)
        best_results.concat(results)
        # adding points for each missing category-event
        while best_results.length != 8 do
          best_results << 16
        end
        participant[:results] = best_results
        participant[:score] = best_results.sum
      end
    end

    # sort based on new rank
    mangekjempere[:men] = mangekjempere[:men].sort_by{ |p| p[1][:score]}
    mangekjempere[:women] = mangekjempere[:women].sort_by{ |p| p[1][:score]}

    # sort out the rest
    participants[:men] = participants[:men].sort_by{|p| [p[1][:events].length, p[1][:events].map{|key,value|value[:rank]}.reduce(:+) * -1]}.reverse
    participants[:women] = participants[:women].sort_by{|p| [p[1][:events].length, p[1][:events].map{|key,value|value[:rank]}.reduce(:+) * -1]}.reverse

    return {
      :participants => {
        :men => mangekjempere[:men].concat(participants[:men]),
        :women => mangekjempere[:women].concat(participants[:women])
      },
      :events => events
    }
  end
end
