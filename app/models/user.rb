class User < ApplicationRecord
  validates :name, presence: true

  def appear
    Redis.current.sadd(:online_users, id)
  end

  def disappear
    Redis.current.srem(:online_users, id)
  end
end
