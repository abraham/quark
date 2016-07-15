class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear if current_user
    stream_for :appearance
    send_user_stats
  end

  def unsubscribed
    current_user.disappear if current_user
    send_user_stats
  end

  def list
    send_user_stats
  end

  def appear(data)
    current_user.appear(on: data['appearing_on'])
  end

  def away
    current_user.away
  end

  def send_user_stats
    AppearanceChannel.broadcast_to(:appearance, current_user_stats)
  end

  private

  def user_names(user_ids)
    User.where(id: user_ids).select(:name, :id)
  end

  def current_user_stats
    total_count = ActionCable.server.connections.count
    users_count = Redis.current.scard(:online_users)
    user_ids = Redis.current.srandmember(:online_users, 5)
    {
      total_online: total_count,
      anonymous_online: total_count - users_count,
      users_online: users_count,
      users: user_names(user_ids)
    }
  end
end
