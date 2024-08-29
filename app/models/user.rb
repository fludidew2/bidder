class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: { buyer: 0, vendor: 1 }

         validates :role, presence: true

         has_many :requests, dependent: :destroy

         has_many :declined_requests
        has_many :declined_requests, through: :declined_requests, source: :request

end
