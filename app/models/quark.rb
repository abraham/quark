class Quark < ApplicationRecord
  belongs_to :user

  scope :since, ->(datetime) { where(['created_at > ?', datetime]) }

  validates :count, presence: true, numericality: { greater_than: 0 }
  validate :not_excessive_counting

  after_commit :update_count

  def self.total_count
    Rails.cache.fetch(:quark_count) do
      Quark.sum(:count)
    end
  end

  private

  def update_count
    current_count = Rails.cache.fetch(:quark_count) { Quark.total_count }
    Rails.cache.write(:quark_count, current_count + count)
  end

  def not_excessive_counting
    errors.add(:quark, 'added too frequently') if user.quarks.since(1.minutes.ago).count > 60
  end
end
