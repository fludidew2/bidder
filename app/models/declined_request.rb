# app/models/declined_request.rb
class DeclinedRequest < ApplicationRecord
  belongs_to :user
  belongs_to :request
  

end