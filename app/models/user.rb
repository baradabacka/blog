class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :evaluations, through: :entries
end