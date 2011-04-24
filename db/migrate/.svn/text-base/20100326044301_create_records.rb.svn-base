class CreateRecords < ActiveRecord::Migration
  def self.up
    create_table :records do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.text :text1
      t.text :text2

      t.timestamps
    end
  end

  def self.down
    drop_table :records
  end
end
