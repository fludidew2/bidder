class Request < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :invoices, dependent: :destroy
  validates :description, :status, :user, presence: true 

  enum status: { live: 0,  shipping: 1, closed: 2,  completed: 3, accepted: 4 }

  has_many :declined_requests
  has_many :declining_users, through: :declined_requests, source: :user

  scope :active_for_user, ->(user) { where.not(id: DeclinedRequest.where(user_id: user.id).select(:request_id)) }
end
