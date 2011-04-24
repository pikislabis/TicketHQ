class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :info
      t.boolean :closed, :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
