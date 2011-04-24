# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def opciones_borrado
  	{ :method => :delete, :confirm => '¿Está seguro?'}
 	end

	def link_to_file(name, file, *args)
		if file != ?/
			file = "#{file}"
		end
		link_to name, file, *args
	end

	def observe_project?(user, project)
		observe = false
		groups = user.groups & project.groups
		groups.each do |x|
			x.observe ? (observe = true; break) : nil
		end
		observe
	end
end
