module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      # Specify that a user/anonymous user has come online
      context = current_user || User
      context.appear
    end

    def disconnect
      # Specify that a user/anonymous user has gone offline
      context = current_user || User
      context.disappear
    end

    protected

    def find_verified_user
      User.find_by(id: cookies.signed[:ws_user_id])
    end
  end
end
