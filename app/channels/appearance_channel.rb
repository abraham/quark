# Notify clients when users go online/offline and how many of them are named
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_for :global
    stream_from "appearance:#{self}"

    # Notify clients who are not the current one that someone has come online
    send_user_stats :global
  end

  def unsubscribed
    send_user_stats :global
  end

  # Available for clients to specifically ask for current users online
  def online
    send_user_stats self
  end

  private

  def send_user_stats(channel)
    success channel, :online, current_users_online
  end

  def user_names(user_ids)
    User.where(id: user_ids).select(:name, :id)
  end

  # Get various stats about the number of users online.
  # This gets called a lot so use Redis cached data.
  def current_users_online
    total_count = ActionCable.server.connections.count
    users_count = Redis.current.scard(:users_online)
    anonymous_count = Redis.current.get(:anonymous_online).to_i
    user_ids = Redis.current.srandmember(:users_online, 5)
    {
      total_online: total_count,
      anonymous_online: [0, anonymous_count].max, # anonymous_count can sometimes mess up and go negative
      users_online: users_count,
      users: user_names(user_ids)
    }
  end
end
