class CreateTicketSubscribes < ActiveRecord::Migration
  def self.up
    create_table :ticket_subscribes do |t|
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_subscribes
  end
end
