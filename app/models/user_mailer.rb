class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += ' Por favor, active su cuenta'
    # Realizamos este paso para que actualice en el objeto user el activation_code, que por algún motivo
    # no reflejaba el código correcto.
    user = User.find(user.id)
    @body[:url]  = "#{APP_CONFIG[:site_url]}/activate/#{user.activation_code}"
    @body[:pass] = user.password
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += ' Su cuenta ha sido activada.'
    @body[:url]  = "#{APP_CONFIG[:site_url]}"
  end
  
  def reset_notification(user)
    setup_email(user)
    @subject    += ' Restablezca su contraseña'
    @body[:url]  = "#{APP_CONFIG[:site_url]}/reset/#{user.reset_code}"
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
