class Admin::GroupsController < AdminController

	def index
		@groups = Group.find(:all).paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(params[:group])
		@group.save
		if @group && @group.valid?
			flash[:notice] = "El grupo se ha creado de forma satisfactoria."
			redirect_to admin_groups_path
		else
			flash[:error] = "Ha habido un error al crear el grupo."
			@group.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
			render :action => 'new'
		end
	end

	def edit
		@group = Group.find(params[:id])	
	end

 	def update
		params[:group][:project_ids] ||= []
		@group = Group.find(params[:id])
		if @group.update_attributes(params[:group])	
			flash[:notice] = "El grupo ha sido actualizado de forma satisfactoria."
			redirect_to admin_groups_path
		else
			flash[:error] = "Ha habido un error al actualizar el grupo."
			@user.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
			render :action => 'edit'
		end
	end

	def show
		@group = Group.find(params[:id])
	end

	def destroy
		@group = Group.find(params[:id])
 		if @group.destroy
			flash[:notice] = "El grupo ha sido eliminado."
		else
			flash[:error] = "Ha ocurrido un error al eliminar el grupo."
		end
		redirect_to("admin/groups")
	end
end
