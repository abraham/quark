# Notify clients when users go online/offline and how many of them are named
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # Notify clients who are not the current one that someone has come online
    # Current stats need to be sent to client before `stream_for` to avoid an error
    send_user_stats :global

    stream_for :global
    stream_from "appearance:#{self}"
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
    anonymous_online = Redis.current.scard(:anonymous_online)
    users_online = Redis.current.scard(:users_online)
    {
      total_online: anonymous_online + users_online,
      anonymous_online: anonymous_online,
      users_online: users_online,
      users: user_names(Redis.current.srandmember(:users_online, 5))
    }
  end
end
