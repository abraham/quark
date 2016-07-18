module OnlineHelper
  def send_user_stats
    AppearanceChannel.broadcast_to(:appearance, current_user_stats)
  end

  private

  def user_names(user_ids)
    User.where(id: user_ids).select(:name, :id)
  end

  def anonymous_online(total_count, users_count)
    total_count - users_count > 0 ? total_count - users_count : 0
  end

  def current_user_stats
    total_count = ActionCable.server.connections.count
    users_count = Redis.current.scard(:online_users)
    user_ids = Redis.current.srandmember(:online_users, 5)
    {
      total_online: total_count,
      anonymous_online: anonymous_online(total_count, users_count),
      users_online: users_count,
      users: user_names(user_ids)
    }
  end
end
