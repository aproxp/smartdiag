class User < ActiveRecord::Base
  attr_accessible :bdate, :first_name, :height, :last_name, :weight, :user_id
  has_many :events, dependent: :destroy
  validates :bdate, :first_name, :height, :last_name, :weight, presence: true
end
