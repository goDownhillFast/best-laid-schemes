class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :activity_id
      t.string :google_event_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.integer :location_id

      t.timestamps
    end
  end
end
