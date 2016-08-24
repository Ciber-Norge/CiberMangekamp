class ResultsController < ApplicationController
  before_filter :authorize
  before_filter :find_event, only: [:mass_new, :mass_create, :mass_edit, :mass_update, :destroy, :edit, :update]
  before_filter :find_result, only: [:edit, :update]

  def edit
  end

  def update
    if @result.update(result_params)
      redirect_to @event
    else
      redner 'edit'
    end
  end

  def mass_edit
  end

  def mass_update
    params['participants'].each do | id, value |
      participant = Participant.find(id)
      result = Result.find_by_participant_id(participant.id)
      if result
        result.score = value[:score]
        result.rank = value[:rank]
        result.save
      else
        result = Result.new(event_id: params[:event_id], participant_id: id, score: value[:score], rank: value[:rank])
        result.save
      end
    end
    redirect_to  @event
  end

  def mass_new
  end

  def mass_create
    params['participants'].each do | id, value |
      participant = Participant.find(id)
      result = Result.new(event_id: params[:event_id], participant_id: id, score: value[:score], rank: value[:rank])
      result.save
    end
    redirect_to @event
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
  
  def find_result
    @result = Result.find(params[:id])
  end
  
  def result_params
    params.require(:result).permit(:score, :rank)
  end
end
