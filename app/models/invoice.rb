class Invoice < ApplicationRecord
  belongs_to :request
  belongs_to :bid

  validates :request_description, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
