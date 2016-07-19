class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :validate_session

  def current_user
    @_current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    # Create a cookie for WebSocket connections to authenticate users with.
    # Make sure it's signed with the app secret so it can't be forged.
    session[:user_id] = user.id
    cookies.signed[:ws_user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
    cookies.signed[:ws_user_id] = nil
  end

  private

  # We want to prevent odd things happening if a users session doesn't match their WebSocket cookie
  def validate_session
    sign_out unless session[:user_id] == cookies.signed[:ws_user_id]
  end
end
