# Reset online user stats when the server starts
Redis.current.del(:users_online)
Redis.current.set(:anonymous_online, 0)
