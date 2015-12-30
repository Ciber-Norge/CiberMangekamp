class ResultsController < ApplicationController
  before_filter :find_event, only: [:mass_new, :mass_create]

  def mass_new
  end

  def mass_create
    params['participants'].each do | id, value |
      participant = Participant.find(id)
      result = Result.new(event_id: params[:event_id], participant_id: id, score: value[:score], rank: value[:rank])
      p result.save
    end        
    redirect_to @event
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
