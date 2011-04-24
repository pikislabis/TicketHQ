# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  layout "layout"

	#before_filter :authorize, :except => [:activate, :new, :create]
	before_filter :prepare_for_mobile
	before_filter :values

	protected	
	  
		# Verifica si hay usuario logueado en el sistema
		# Si no es así, redirige a la pantalla principal

		def authorize
			unless current_user
				reset_session
				flash[:notice] = "Por favor, identifiquese"

				redirect_to('/login')
			end
		end

	private
	
		def mobile_device?
			if session[:mobile_param]
				session[:mobile_param] == "1"
			else
				request.user_agent =~ /Mobile|webOS/
			end
		end

		helper_method :mobile_device?

		def prepare_for_mobile
			session[:mobile_param] = params[:mobile] if params[:mobile]
			request.format  = :mobile if mobile_device?
		end
		
		def values
  		@type_state = ["Nuevo", "Abierto", "Resuelto", "Reasignado"]
  		@type_priorities = ["Baja", "Media", "Alta"]
  		@type_origin = ["Manual", "e-mail"]
  	end
end
