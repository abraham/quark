class User < ApplicationRecord
  has_many :quarks
  validates :name, presence: true

  def appear
    Redis.current.sadd(:users_online, id)
  end

  def disappear
    Redis.current.srem(:users_online, id)
  end

  def self.appear
    Redis.current.incr(:anonymous_online)
  end

  def self.disappear
    Redis.current.decr(:anonymous_online)
  end
end
