class SeasonsController < ApplicationController
  def index
    @seasons = Season.order('year DESC')
  end

  def show
    @season = Season.find(params[:id])
  end

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(season_params)
    if @season.save
      redirect_to @season
    end
  end

  private

  def season_params
    params.require(:season).permit(:title, :year)
  end
end
