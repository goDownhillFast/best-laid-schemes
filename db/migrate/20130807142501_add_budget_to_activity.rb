class AddBudgetToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :budget, :float
  end
end
