class AddAdminUser < ActiveRecord::Migration
  def self.up
    u = User.new
    u.name= 'Administrador'
    u.login= 'admin'
    u.password= 'admin'
    u.password_confirmation= 'admin'
    u.email= 'tickethq.rails@gmail.com'
    u.admin= true
    
    u.register!
    u.activate! 
  end
  
  def self.down
    u = User.find_by_login('admin')
    u.destroy
  end
end