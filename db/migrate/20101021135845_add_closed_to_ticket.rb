class AddClosedToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :tickets, :closed
  end
end
