class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :records, :dependent => :destroy
	belongs_to :project
  belongs_to :status

	has_many :ticket_subscribes
	has_many :user_subs, :through => :ticket_subscribes, :source => :user
	
	has_many :attaches, :through => :records

	has_many :labels, :dependent => :destroy
	
	validates_presence_of :project_id

	def label_attributes=(label_attributes)
    label_attributes.each do |attributes|
      labels.build(attributes)
    end
  end

	def label_attributes_edit=(label_attributes)
		label_attributes.each do |attributes|
			label = Label.find(attributes.to_a[0])
			label.update_attributes(attributes.to_a[1])
    end
  end

	def users
		users = self.project.groups.map{|x| x.users }
		users.flatten!
		users.uniq!
		users
	end

end
