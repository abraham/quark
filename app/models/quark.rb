class Quark < ApplicationRecord
  belongs_to :user

  scope :since, ->(datetime) { where(['created_at > ?', datetime]) }

  validates :count, presence: true, numericality: { greater_than: 0 }
  validate :not_excessive_counting

  private

  def not_excessive_counting
    errors.add(:quark, 'added too frequently') if user.quarks.since(1.minutes.ago).count > 60
  end
end
