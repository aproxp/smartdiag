class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :entered_at
      t.integer :event_type
      t.integer :body_part
      t.integer :level
      t.integer :description
      t.integer :quantity
      t.integer :temperature
      t.string :drugs
      t.integer :activity_type
      t.datetime :activity_since

      t.timestamps
    end
  end
end
