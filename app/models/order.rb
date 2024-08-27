class Order < ApplicationRecord
  belongs_to :vendor
  belongs_to :buyer
  belongs_to :request
end
