class EventsController < ApplicationController
  before_filter :find_event, only: [:show, :edit, :update, :destroy]

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

  private

  def event_params
    params.require(:event).permit(:title, :sport, :date, :venue)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
