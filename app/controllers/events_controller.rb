class EventsController < ApplicationController
  before_filter :authorize, only: [:new, :edit, :update, :destroy, :mass_add, :mass_create, :edit_result, :update_result]
  before_filter :find_event, only: [:show, :edit, :update, :destroy, :mass_add, :mass_create, :delete_participant, :edit_result, :update_result, :mass_new_results, :mass_create_results, :mass_edit_results, :mass_update_results]
  before_filter :find_participant, only: [:delete_participant, :edit_result, :update_result]

  def show
    @users = User.order('name ASC')
  end

  def new
    @event = Event.new
    @event.season_id = params[:season_id]
    @season = Season.find(params[:season_id])
  end

  def create
    @season = Season.find(params[:season_id])
    @event = @season.events.create(event_params)
    if @event.save
      redirect_to @event
    else
      render  'new'
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  # Participants
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

  def delete_participant
    if @participant
      @participant.destroy
    end
    redirect_to @event
  end

  # Results
  def mass_edit_results
  end

  def mass_update_results
    params['participants'].each do | id, value |
      participant = @event.participants.find(id)
      if value[:rank]
        participant.score = value[:score]
        participant.rank = value[:rank]
        participant.save
      end
    end
    redirect_to  @event
  end

  def edit_result
  end

  def update_result
    if @participant.update(result_params)
      redirect_to @event
    else
      render 'edit'
    end
  end


  private

  def event_params
    params.require(:event).permit(:title, :sport, :date, :venue, :category_id)
  end
  
  def result_params
    params.require(:participant).permit(:score, :rank)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def find_participant
    @participant = Participant.find(params[:participant_id])
  end
end
