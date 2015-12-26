class ParticipantsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    unless event.participants.find_by_user_id(params[:user][:user_id])
      participant = event.participants.create(user_params)
      if participant.save
        redirect_to season_event_path(event.season_id, event.id) and return
      end
    end

    redirect_to season_event_path(event.season_id, event.id)
  end

  def destroy
    event = Event.find(params[:event_id])
    participant = Participant.find(params[:id])
    if participant
      participant.destroy
    end
    redirect_to season_event_path(event.season_id, event.id)
  end

  private

  def user_params
    params.require(:user).permit(:event_id, :user_id)
  end
end
