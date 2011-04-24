class ChangeStateColumnTicket < ActiveRecord::Migration
  def self.up
    change_column :tickets, :state, :integer
    rename_column :tickets, :state, :status_id
  end

  def self.down
    change_column :tickets, :status_id, :string
    rename_column :tickets, :status_id, :state
  end
end
