class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :name
      t.integer :project_id
      t.integer :order

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
