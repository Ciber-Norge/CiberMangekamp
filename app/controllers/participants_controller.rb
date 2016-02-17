class ParticipantsController < ApplicationController
  before_filter :find_event, only: [:create, :destroy, :mass_add, :mass_create]
  before_filter :find_participant, only: [:destroy]

  def create
    unless @event.participants.find_by_user_id(params[:user][:user_id])
      participant = @event.participants.create(user_params)
      participant.save
    end

    redirect_to @event
  end

  def destroy
    if @participant
      @participant.destroy
    end
    redirect_to @event
  end

  def mass_add
    @participants = @event.participants
  end

  def mass_create
    params[:participants].each do | user_id, value |
      unless @event.participants.find_by_user_id(user_id)
        participant = @event.participants.create(:event_id => @event.id, :user_id => user_id)
        participant.save
      end
    end

    redirect_to @event
  end

  private

  def user_params
    params.require(:user).permit(:event_id, :user_id)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_participant
    @participant = Participant.find(params[:id])
  end
end
