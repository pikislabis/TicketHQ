class RenameFilesToAttaches < ActiveRecord::Migration
  def self.up
		rename_table :files, :attaches
  end

  def self.down
		rename_table :attaches, :files
  end
end
