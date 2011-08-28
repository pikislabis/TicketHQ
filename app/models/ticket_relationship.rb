class TicketRelationship < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_o, :class_name => "Ticket", :foreign_key => "ticket_o_id"
  belongs_to :user
end
