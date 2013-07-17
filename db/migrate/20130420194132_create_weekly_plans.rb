class CreateWeeklyPlans < ActiveRecord::Migration
  def change
    create_table :weekly_plans do |t|
      t.datetime :start_date
      t.float :number_of_hours
      t.integer :activity_id

      t.timestamps
    end
  end
end
