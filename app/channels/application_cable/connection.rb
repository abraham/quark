module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    attr_accessor :client_id

    def connect
      self.current_user = find_verified_user
      self.client_id = cookies.signed[:client_id]

      # Specify that a user/anonymous user has come online
      if current_user
        current_user.appear
      else
        User.appear(client_id)
      end
    end

    def disconnect
      # Specify that a user/anonymous user has gone offline
      if current_user
        current_user.disappear
      else
        User.disappear(client_id)
      end
    end

    protected

    def find_verified_user
      User.find_by(id: cookies.signed[:ws_user_id])
    end
  end
end
