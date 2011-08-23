class RecordsController < ApplicationController
  include AuthenticatedSystem
  
  before_filter :authorize
  before_filter :find_record, :only => [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def new
    @record = Record.new
    @record.attaches.build
  end
  
  def create
    ticket_old = Ticket.find(params[:record][:ticket_id])
    @ticket = Ticket.find(params[:record][:ticket_id])
    @ticket.update_attributes(params[:ticket])
    @record = Record.new(params[:record])
    @record.user = current_user
    @record.text2 = cambios_tickets(ticket_old, @ticket)
    @record.text2 << " Añadido un/os fichero/s." if !params[:record][:attach_attributes].blank?
    @record.text2 << " Añadido un comentario." if !params[:record][:text1] == ""
    if @record.save
      flash[:notice] = 'El ticket ha sido actualizado correctamente.'
      redirect_to(@ticket)
    else
      flash[:error] = 'Ha habido un error al actualizar el ticket.'
      redirect_to(@ticket)
    end  
  end
  
  private
    def find_record
      @record = Record.find(params[:id])
    end
    
    def cambios_tickets (ticket1, ticket2)
  	  #TODO Controlar el cambio en las etiquetas.
  	  cambios = ""
      cambios << " Cambio de estado a #{ticket2.status.name}." if ticket1.status.name != ticket2.status.name
      cambios << " Cambio de prioridad a #{ticket2.priority}." if ticket1.priority != ticket2.priority
  	  if ticket1.assigned_to != ticket2.assigned_to and ticket2.assigned_to.nil?
				cambios << " Se ha eliminado la asignacion del ticket."
			elsif ticket1.assigned_to != ticket2.assigned_to and !ticket2.assigned_to.nil?
  	    cambios << " Asignado a #{User.find(ticket2.assigned_to).login}."
  	  end
  	  cambios
  	end
end
