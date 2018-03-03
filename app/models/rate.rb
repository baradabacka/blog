class Rate < ActiveRecord::Base
  belongs_to :post
  has_one :user, through: :entry
end
