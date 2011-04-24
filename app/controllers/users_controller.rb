class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
 
  before_filter :authorize, :except => [:activate, :forgot, :reset]
 
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge] 
  
  def index
    @tickets_assigned = Ticket.find(:all, :conditions => {:assigned_to => current_user.id })
  end

	def show
		@user = User.find(params[:id])
	end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'El usuario ha sido actualizado correctamente.'
      redirect_to(@user)
    else
      flash[:error] = 'Ha fallado la actualización del usuario.'
      render :action => "edit"
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "¡Registro completado! Por favor, inicie sesión."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "No existe código de activación.  Por favor, revise el correo."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "No se encontró ningun usuario con ese código de activación."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def forgot_password
    @user = User.new
    flash[:notice] = "Introduzca su email para restaurar la contraseña."
    render(:layout => false)
  end
  
  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:notice] = "Se ha enviado un correo con las instrucciones para restaurar la contraseña a #{user.email}"
      else
        flash[:error] = "#{params[:user][:email]} no existe en el sistema."
      end
      redirect_to('/login')
    else
      flash[:notice] = "Introduzca su dirección de correo."
      render(:layout => false)
    end
  end
  
  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        self.current_user = @user
        @user.delete_reset_code
        flash[:notice] = "La contraseña fue restablecida para #{@user.login}"
        redirect_back_or_default('/')
      else
        render :action => :reset
      end
    else
      flash[:notice] = "Introduzca la nueva contraseña."
      render(:layout => false)
    end
  end

protected
  def find_user
    @user = User.find(params[:id])
  end
end
