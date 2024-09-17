class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :bids, dependent: :destroy

  after_create :create_profile

  enum stripe_status: [:incomplete, :complete, :pending_verification]


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: { buyer: 0, vendor: 1 }

         validates :role, presence: true

         has_many :requests, dependent: :destroy

         has_many :declined_requests
        has_many :declined_requests, through: :declined_requests, source: :request


        def stripe_account_setup?
          stripe_account_id.present? && stripe_status == 'complete' 
        end
      

        private

        def create_profile
          Profile.create(user: self)
        end

end
