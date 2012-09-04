module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "ENSU Library Catalogue"
    if @title.nil?
      return base_title
    else
      return "#{base_title} | #{@title}"
    end
  end
end