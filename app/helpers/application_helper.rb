module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "ENSU Library Catalogue"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "ENSU Library Catalogue", :class => "round")
  end
  
end