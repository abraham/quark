class AppearanceChannel < ApplicationCable::Channel
  include OnlineHelper

  def subscribed
    stream_for :appearance
    send_user_stats
  end

  def unsubscribed
    send_user_stats
  end

  def list
    send_user_stats
  end
end
