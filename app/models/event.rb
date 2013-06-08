class Event < ActiveRecord::Base
  attr_accessible :activity_since, :activity_type, :body_part, :description, :drugs, :entered_at, :event_type, :level, :quantity, :temperature, :event_id, :user_id
  belongs_to :user
  validates_presence_of :user, :entered_at
  validates :event_type, presence: true, inclusion: { in: (0...2) }

  # validates :body_part, :description, :level, presence: true, if:
  current = Proc.new { |a| a.event_type }







  case current

  when 0
    validates :body_part, :description, :level, presence: true
    validates :drugs, :quantity, :temperature, presence: false
  when 1
    validates :quantity, :temperature, presence: true
    validates :drugs, :body_part, :description, :level, presence: false
  when 2
    validates :drugs, presence: true
    validates :body_part, :description, :level, :quantity, :temperature, presence: false
  end



end
