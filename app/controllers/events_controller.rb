class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @users = User.order('name ASC')
  end

  def new
    @event = Event.new
  end

  def create
    @season = Season.find(params[:season_id])
    @event = @season.events.create(event_params)
    if @event.save
      redirect_to @event
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :sport, :date, :venue)
  end
end
