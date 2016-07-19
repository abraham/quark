module ApplicationCable
  class Channel < ActionCable::Channel::Base
    include ApplicationHelper

    private

    # Simple success wrapper to ensure consistant response format
    def success(channel, action, values)
      self.class.broadcast_to(channel, values.merge(action: action, status: :ok))
    end

    # Simple error wrapper to ensure consistant response format
    def error(channel, action, messages)
      self.class.broadcast_to(channel, action: action, status: :error, messages: messages)
    end
  end
end
