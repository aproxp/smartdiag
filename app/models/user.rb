class User < ActiveRecord::Base
  attr_accessible :bdate, :first_name, :height, :last_name, :weight
end
