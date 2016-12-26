class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_admin
    @current_admin ||= User.find(session[:admin_id]) if session[:admin_id]
  end

  def authorize
    redirect_to '/login' unless current_admin
  end

  def logged_in?
    current_admin != nil
  end
end
