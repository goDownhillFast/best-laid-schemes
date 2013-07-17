class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.float :total_hours
      t.float :hours_remaining
      t.integer :activity_id

      t.timestamps
    end
  end
end
