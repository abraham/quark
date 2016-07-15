class Quark < ApplicationRecord
  belongs_to :user
  validates :count, presence: true, numericality: { greater_than: 0 }
end
