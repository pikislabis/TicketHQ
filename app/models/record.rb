class Record < ActiveRecord::Base
  belongs_to :user
	belongs_to :ticket
	has_many :attaches, :dependent => :destroy
	
	def attach_attributes=(attach_attributes)
		order = 0
    attach_attributes.each do |attributes|
			attributes["file"].blank? ? nil : attaches.build(attributes) 
    end
  end

	def attach_attributes_edit=(attach_attributes)
    attach_attributes.each do |attributes|
      attach = Attach.find(attributes.to_a[0])
			attach.update_attributes(attributes.to_a[1])
			attach.file.blank? ? attach.destroy : nil
    end
  end
	
	
end
