class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :day
      t.boolean :complete
      t.float :number_of_hours
      t.integer :category_id

      t.timestamps
    end
  end
end
