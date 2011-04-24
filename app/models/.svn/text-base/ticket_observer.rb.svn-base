class TicketObserver < ActiveRecord::Observer
  def after_update(ticket)
    ticket.user_subs.each do |user|
			if observe_project?(user, ticket.project)
      	TicketMailer.deliver_ticket_change(user, ticket)
			end
    end
  end

	def observe_project?(user, project)
		observe = false
		groups = user.groups & project.groups
		groups.each do |x|
			x.observe ? (observe = true; break) : nil
		end
		observe
	end
end
