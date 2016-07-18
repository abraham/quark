module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include OnlineHelper

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      current_user.appear if current_user
    end

    def disconnect
      current_user.disappear if current_user
    end

    protected

    def find_verified_user
      User.find_by(id: cookies.signed[:ws_user_id])
    end
  end
end
