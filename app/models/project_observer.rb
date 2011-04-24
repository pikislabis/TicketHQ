class ProjectObserver < ActiveRecord::Observer
	observe :ticket
	
	def after_create(ticket)
		ticket.project.user_subs.each do |user|
			if observe_project?(user, ticket.project)
      	ProjectMailer.deliver_ticket_create(user, ticket)
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
