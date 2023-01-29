# frozen_string_literal: true

class AddAdminToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type, :string, default: 'User'
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_index :users, :type
  end
end
