class AddCloseToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :close, :boolean, :default => false
  end

  def self.down
    remove_column :statuses, :close
  end
end