class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :request
  has_many :invoices, dependent: :destroy


  enum status: { pending: 0, winning: 1, declined: 2 }
  validate :user_must_be_vendor

  private

  def user_must_be_vendor
    errors.add(:user, "must be a vendor") unless user&.role == "vendor"
  end
end
