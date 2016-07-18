module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include OnlineHelper

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      if current_user
        current_user.appear
      else
        User.appear
      end
    end

    def disconnect
      if current_user
        current_user.disappear
      else
        User.disappear
      end
    end

    protected

    def find_verified_user
      User.find_by(id: cookies.signed[:ws_user_id])
    end
  end
end
