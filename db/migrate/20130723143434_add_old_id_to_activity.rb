class AddOldIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :old_id, :integer
  end
end
