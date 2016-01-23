class UsersController < ApplicationController
  before_filter :find_user, only: [:show, :edit, :update]
  def index
    @users = User.order('name DESC')
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :sex)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
