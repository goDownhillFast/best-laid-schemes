class AddBudgetToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :budget, :float
  end
end
