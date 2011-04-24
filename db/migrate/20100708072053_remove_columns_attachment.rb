class RemoveColumnsAttachment < ActiveRecord::Migration
  def self.up
		remove_column :attachments, :name
		remove_column :attachments, :content_type
		remove_column :attachments, :file_size
  end

  def self.down
  end
end
