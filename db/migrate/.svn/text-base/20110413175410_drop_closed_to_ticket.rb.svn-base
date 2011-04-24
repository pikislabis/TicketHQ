class DropClosedToTicket < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :closed
  end

  def self.down
    add_column :tickets, :closed, :boolean
  end
end