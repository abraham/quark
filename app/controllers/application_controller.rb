class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    session[:user_id] = user.id
    cookies.signed[:ws_user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
    cookies.signed[:ws_user_id] = nil
  end
end
