class User < ApplicationRecord
  has_many :quarks

  validates :name, presence: true

  scope :lower_name, -> (name) { where('lower(name) = ?', name.downcase) }

  def appear
    Redis.current.sadd(:users_online, id)
  end

  def disappear
    Redis.current.srem(:users_online, id)
  end

  def self.appear(uuid)
    Redis.current.sadd(:anonymous_online, uuid)
  end

  def self.disappear(uuid)
    Redis.current.srem(:anonymous_online, uuid)
  end
end
