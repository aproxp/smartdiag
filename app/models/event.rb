class Event < ActiveRecord::Base
  attr_accessible :activity_since, :activity_type, :body_part, :description, :drugs, :entered_at, :event_type, :level, :quantity, :temperature, :event_id
  belongs_to :user
end
