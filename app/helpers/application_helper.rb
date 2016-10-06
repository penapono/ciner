module ApplicationHelper
  # Return the full title on a per-pages basis
  def full_title(page_title = '')
    base_title = "CINER"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
