class TicketMailer < ActionMailer::Base
  def ticket_change(user, ticket)
    setup_email(user)
    @subject    += ' Cambios en un ticket.'
    @body[:ticket] = ticket
    @body[:url]  = "#{APP_CONFIG[:site_url]}/tickets/#{ticket.id}"
  end
  
  def wrong_mail(user)
    setup_email(user)
    @subject += ' Error en mail.'
    @body[:projects] = user.groups.map{|x| x.projects unless !x.make}.flatten.uniq.delete_if{|y| y.nil?}
  end
  
  def receive(email)
    user = User.find_by_email(email.from[0]) or return
    project_id, title = email.subject.scan(/\[(\d)\]\s([\w|\s]*)/).first
    
    begin
      project = Project.find(project_id)
    rescue ActiveRecord::RecordNotFound
      wrong_mail(user)
      return
    end
    
    user.groups.map{|x| 
      x.projects unless !x.make}.flatten.include?(project) ? nil : (mail = TicketMailer.create_wrong_mail(user); 
                                                                    TicketMailer.deliver(mail); 
                                                                    return)
    
    #Solo haremos uso de la parte del cuerpo del email que está en formato texto plano.
    if email.multipart?
      email.parts.each do |part|
				header = part.content_type.to_s
				if header.include? "multipart/alternative"
				  part.parts.each do |part2|
						header2 = part2.content_type.to_s
						if header2.include? "text/plain"
						  part2.set_disposition("inline")
							@description = part2.body
							break
						end
					end
				elsif header.include? "text/plain"
				  part.set_disposition("inline")
					@description = part.body
					break
				end
			end
		else
			@description = email.body
		end
		
    ticket = Ticket.create(:title => title, :description => @description.to_s, :user => user,
                            :status => Project.find(project_id).statuses.first, :priority => "Media", 
                            :project => project)
    record = ticket.records.create(:user => user, :text2 => "Ticket creado")
    if email.has_attachments?
			email.attachments.each do |attach|
			  record.attaches.create(:file => attach)
  		end
		end
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
