class Attach < ActiveRecord::Base
  belongs_to :record
  has_attached_file :file,
                    :url => "/files/:id/:basename.:extension",
                    :path => ":rails_root/public/files/:id/:basename.:extension"

	validates_attachment_size :file, :less_than => 3.megabytes
end
