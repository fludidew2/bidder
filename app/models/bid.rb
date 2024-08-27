class Bid < ApplicationRecord
  belongs_to :vendor
  belongs_to :request
end
