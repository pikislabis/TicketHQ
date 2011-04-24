class Admin::ProjectsController < AdminController
  
	def index
		@projects = Project.find(:all).paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@project = Project.new
		3.times {@project.statuses.build}
	end

	def create
		@project = Project.new(params[:project])
		if params[:statuses] == "default"
	    @type_state.length.times {@project.statuses.build}
	    @project.statuses.each_with_index do |status, index|
	      status.name = @type_state[index]
				status.order = index + 1
	    end
	  end
		if @project && @project.valid?
		  @project.save
			flash[:notice] = "El proyecto se ha creado de forma satisfactoria."
			redirect_to admin_projects_path
		else
			flash[:error] = "Ha habido un error al crear el proyecto."
			@project.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
			render :action => 'new'
		end
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update_attributes(params[:project])
			flash[:notice] = "El proyecto ha sido actualizado de forma satisfactoria."
			redirect_to admin_projects_path
		else
			flash[:error] = "Ha habido un error al actualizar el proyecto."
			@project.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
			render :action => 'edit'
		end
	end
	
	def destroy
		@project = Project.find(params[:id])
 		if @project.destroy
			flash[:notice] = "El proyecto ha sido eliminado."
			redirect_to admin_projects_path
		else
			flash[:error] = "Ha ocurrido un error al eliminar el proyecto."
			redirect_to admin_projects_path
		end
	end 
end
