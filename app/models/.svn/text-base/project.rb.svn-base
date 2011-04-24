class Project < ActiveRecord::Base

	has_and_belongs_to_many :groups	
	has_many :tickets, :dependent => :destroy
		
	has_many :project_subscribes, :dependent => :destroy
	has_many :user_subs, :through => :project_subscribes, :source => :user
	
	has_many :statuses, :order => 'statuses.order', :dependent => :destroy

  validates_presence_of :name
	validates_length_of :name, :in => 3..15
  validates_uniqueness_of :name, :case_sensitive => false
	
	validates_length_of :info, :maximum => 50000, :allow_blank => true

  def status_attributes=(status_attributes)
		order = 0
    status_attributes.each do |attributes|
			order += 1 
			attributes.merge!({"order" => order})
			attributes["name"].blank? ? nil : statuses.build(attributes) 
    end
  end

	def status_attributes_edit=(status_attributes)
    status_attributes.each do |attributes|
      status = Status.find(attributes.to_a[0])
			status.update_attributes(attributes.to_a[1])
			status.name.blank? ? status.destroy : nil
    end
  end
  
  def users
    usuarios = self.groups.map{|g| g.users}.flatten.uniq.delete_if{|y| y.nil?}
    usuarios
  end

	class << self

    # Proyectos en los que el usuario pasado por parámetro tiene el privilegio pasado como atributo
		def proyectos(usuario, atributo)
      if usuario.admin? 
  			projects = Project.find(:all)
  		else
  		  projects = usuario.groups.map {|x| x.projects unless !x.send(atributo)}.flatten.uniq.delete_if{|y| y.nil?}
  		end
  		projects
    end
    
    def current=(project)
      @current_project = project
    end
    
    def current
      @current_project.is_a?(Project) ? @current_project : nil
    end
	end

end
