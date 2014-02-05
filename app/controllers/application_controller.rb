class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def ensure_that_signed_in 
    redirect_to signin_path, notice:'you ought to be signed in' if current_user.nil?
  end

  def ensure_that_is_admin
    ensure_that_signed_in
    redirect_to breweries_path, notice:'only admins are allowed to do that' if not current_user.admin?
  end

  def current_user
  	return nil if session[:user_id].nil?
  	User.find(session[:user_id])
  end
end
