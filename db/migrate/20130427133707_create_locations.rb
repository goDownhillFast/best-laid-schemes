class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :activity_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
