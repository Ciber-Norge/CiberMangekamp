class ParticipantsController < ApplicationController
  def create
    p params
    @event = Event.find(params[:event_id])
    @participant = @event.participants.create(user_params)
    if @participant.save
      redirect_to season_event_path(@event.season_id, @event.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:event_id, :user_id)
  end
end
