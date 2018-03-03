class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :rates, through: :entries
end
