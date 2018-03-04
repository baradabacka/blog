class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :evaluations, dependent: :delete_all
end