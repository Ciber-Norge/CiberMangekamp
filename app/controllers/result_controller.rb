class ResultController < ApplicationController
  before_filter :authorize
  before_filter :find_event, only: [:destroy, :edit, :update]
  before_filter :find_result, only: [:destroy, :edit, :update]

  def edit
  end

  def update
    if @result.update(result_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
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
