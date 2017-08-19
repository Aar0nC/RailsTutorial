module ApplicationHelper

  #Returns the full properly formatted title of a given page
  def full_title(pageTitle = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if pageTitle.empty?
      base_title
    else
      pageTitle + " | " + base_title
    end
  end
end
