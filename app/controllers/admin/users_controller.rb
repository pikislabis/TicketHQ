class Admin::UsersController < AdminController
  
	def index
		@users = User.find(:all).paginate(:page => params[:page], :per_page => 10)
	end

	def new
    @user = User.new
		@groups = Group.find :all
  end

  def create
		@groups = Group.find :all
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "Se ha enviado un correo al usuario para que active su cuenta."
      redirect_to admin_users_path
    else
      flash[:error]  = "Ha habido un error y no se ha podido realizar el registro."
      @user.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
      render :action => 'new'
    end
  end

	def edit
		@user = User.find(params[:id])
	end
	
	def update
		params[:user][:group_ids] ||= []
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])	
			flash[:notice] = "El usuario ha sido actualizado de forma satisfactoria."
			redirect_to admin_users_path
		else
			flash[:error] = "Ha habido un error al actualizar el usuario."
			@user.errors.each {|x| flash[:error] += "<br/> - El campo <b>#{x[0]}</b> #{x[1]}"}
			render :action => 'edit'
		end
	end

	def show
		@user = User.find(params[:id])
	end
	
	def destroy
		@user = User.find(params[:id])
 		if @user.destroy
			flash[:notice] = "El usuario ha sido eliminado."
		else
			flash[:error] = "Ha ocurrido un error al eliminar el usuario."
		end
		redirect_to("admin/groups")
	end
end
