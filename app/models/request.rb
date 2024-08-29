class Request < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  validates :description, :status, :user, presence: true 

  has_many :declined_requests
  has_many :declining_users, through: :declined_requests, source: :user

  scope :active_for_user, ->(user) { where.not(id: DeclinedRequest.where(user_id: user.id).select(:request_id)) }
end
