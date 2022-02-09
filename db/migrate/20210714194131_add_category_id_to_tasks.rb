# frozen_string_literal: true

class AddCategoryIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :category_id, :integer
    add_index :tasks, :category_id
  end
end
