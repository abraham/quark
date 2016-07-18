module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include OnlineHelper

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      context = current_user || User
      context.appear
    end

    def disconnect
      context = current_user || User
      context.disappear
    end

    protected

    def find_verified_user
      User.find_by(id: cookies.signed[:ws_user_id])
    end
  end
end
