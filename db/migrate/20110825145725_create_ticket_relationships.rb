class CreateTicketRelationships < ActiveRecord::Migration
  def self.up
    create_table :ticket_relationships do |t|
      t.integer :ticket_id
      t.integer :ticket_o_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_relationships
  end
end
