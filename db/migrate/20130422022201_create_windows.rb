class CreateWindows < ActiveRecord::Migration
  def change
    create_table :windows do |t|
      t.integer :activity_id
      t.float :end_time
      t.float :begin_time
      t.integer :day_of_week

      t.timestamps
    end
  end
end
