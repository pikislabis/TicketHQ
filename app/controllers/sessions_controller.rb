# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :authorize, :except => [:new, :create]
  
  # render new.rhtml
  def new
    render(:layout => false)
  end

  def create
    logout_keeping_session!  
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      # flash[:notice] = ""
    else
      flash[:error] = "No ha podido iniciar sesión como '#{params[:login]}'.\n
      <a href =/forgot_password>¿Olvidó su contraseña?</a>"
      @login       = params[:login]
      @remember_me = params[:remember_me]
      redirect_to ('/login')
    end
  end
  
  def destroy
    logout_killing_session!
    flash[:notice] = "Ha sido desconectado del sistema."
    redirect_back_or_default('/login')
  end
end