class Request < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  validates :description, :status, :user, presence: true 
end
