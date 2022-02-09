# frozen_string_literal: true

class AddResultsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :results, :text
  end
end
