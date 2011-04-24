module ProjectHelper
  def add_status_link (name)
    link_to_function name do |page|
		  1.times {page.insert_html :bottom, :statuses, :partial => 'status', :object => Status.new}
	end
  end
end