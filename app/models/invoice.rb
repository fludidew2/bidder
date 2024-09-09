class Invoice < ApplicationRecord
  belongs_to :request
  belongs_to :bid

  enum status: { pending: 0, paid: 1, cancelled: 2 }

  validates :request_description, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
