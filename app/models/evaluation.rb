class Evaluation < ActiveRecord::Base
  belongs_to :entry
  has_one :user, through: :entry

  validates :value, inclusion: { in: [1..5] }
end