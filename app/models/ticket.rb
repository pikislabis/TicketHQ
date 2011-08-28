class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :records, :dependent => :destroy
	belongs_to :project
  belongs_to :status

	has_many :ticket_subscribes
	has_many :user_subs, :through => :ticket_subscribes, :source => :user
	
	has_many :attaches, :through => :records

	has_many :labels, :dependent => :destroy
	
	has_many :ticketRelationships
	has_many :inverse_ticketRelationships, :class_name => "TicketRelationship", :foreign_key => "ticket_o_id"
	has_many :direct_tickets, :through => :ticketRelationships, :source => :ticket_o
  has_many :inverse_tickets, :through => :inverse_ticketRelationships, :source => :ticket
  
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

  def related_tickets
    direct_tickets | inverse_tickets
  end
  

	def users
		users = self.project.groups.map{|x| x.users }
		users.flatten!
		users.uniq!
		users
	end

end
