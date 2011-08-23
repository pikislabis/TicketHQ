module RecordsHelper
  def add_attach_link (name)
    link_to_function name do |page|
		  1.times {page.insert_html :bottom, :attaches, :partial => 'attach', :object => Attach.new}
	  end
  end
end
