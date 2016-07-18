module OnlineHelper
  def send_user_stats
    AppearanceChannel.broadcast_to(:appearance, current_user_stats)
  end

  private

  def user_names(user_ids)
    User.where(id: user_ids).select(:name, :id)
  end

  def current_user_stats
    total_count = ActionCable.server.connections.count
    users_count = Redis.current.scard(:users_online)
    user_ids = Redis.current.srandmember(:users_online, 5)
    {
      total_online: total_count,
      anonymous_online: Redis.current.get(:anonymous_online),
      users_online: users_count,
      users: user_names(user_ids)
    }
  end
end
