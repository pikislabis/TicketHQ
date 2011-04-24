class ProjectMailer < ActionMailer::Base
  def ticket_create(user, ticket)
		setup_email(user)
    @subject    += ' Nuevo ticket.'
    @body[:ticket] = ticket
    @body[:url]  = "#{APP_CONFIG[:site_url]}/tickets/#{ticket.id}"	
	end

	protected
  	def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "Administrador TicketHQ"
      @subject     = "[#{APP_CONFIG[:site_name]}]"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
