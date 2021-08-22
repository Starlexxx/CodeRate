class AddTestsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :tests, :text
  end
end
