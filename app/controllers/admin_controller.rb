class AdminController < ApplicationController
	include AuthenticatedSystem  

  before_filter :authorize
	before_filter :authorize_admin
	
	protected
		def authorize_admin
			if !current_user.admin?
				flash[:error] = "No tiene privilegios para realizar esta acción."	
				redirect_to("/")			
			end
		end
end
