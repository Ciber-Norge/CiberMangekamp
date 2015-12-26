class SeasonsController < ApplicationController
  before_filter :find_season, only: [:show, :edit, :update, :destroy]

  def index
    @seasons = Season.order('year DESC')
  end

  def show
  end

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(season_params)
    if @season.save
      redirect_to @season
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @season.update(season_params)
      redirect_to @season
    else
      render 'edit'
    end
  end

  def destroy
    @season.destroy
    redirect_to root_path
  end

  private

  def season_params
    params.require(:season).permit(:title, :year)
  end

  def find_season
    @season = Season.find(params[:id])
  end
end
