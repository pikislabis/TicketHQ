module TicketHelper
  def add_label_link(name)
    link_to_function name do |page|
			6.times {page.insert_html :bottom, :labels, :partial => 'label', :object => Label.new}
		end
  end
end
