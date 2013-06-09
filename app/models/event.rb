class Event < ActiveRecord::Base
  attr_accessible :activity_since, :activity_type, :body_part, :description, :drugs, :entered_at, :event_type, :level, :quantity, :temperature, :event_id, :user_id
  belongs_to :user
  validates :user, :entered_at, :event_type, :activity_since, presence: true
  validates :event_type, inclusion: { in: (0..2) }

  validates :body_part, :description, :level, presence: true, if: :is_type_0?
  validates :body_part, inclusion: { in: (1..7)}, if: :is_type_0?
  validates :description, inclusion: { in: (1..4)}, if: :is_type_0?
  validates :level, inclusion: { in: (0..10)}, if: :is_type_0?
  validates :drugs, :quantity, :temperature, length: {is: 0, message: "must be empty"}, if: :is_type_0?

  validates :quantity, :temperature, presence: true, if: :is_type_1?
  validates :quantity, inclusion: { in: (1..3)}, if: :is_type_1?
  validates :temperature, inclusion: { in: (1..2)}, if: :is_type_1?
  validates :drugs, :body_part, :description, :level, length: {is: 0, message: "must be empty"}, if: :is_type_1?

  validates :drugs, presence: true, if: :is_type_2?
  validates :body_part, :description, :level, :quantity, :temperature, length: {is: 0, message: "must be empty"}, if: :is_type_2?

  validates :activity_type, inclusion: { in: (1..4)}

  private
    def is_type_0?
      self.event_type==0
    end

    def is_type_1?
      self.event_type==1
    end

    def is_type_2?
      self.event_type==2
    end
end
