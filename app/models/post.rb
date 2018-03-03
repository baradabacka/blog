class Post < ActiveRecord::Base
  belongs_to :user
  has_many :rates, dependent: :delete_all
end
