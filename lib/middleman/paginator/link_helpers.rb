module Paginator::LinkHelpers
  def previous_page_link(options = {})
    page = @locs[:paginator][:page]
    return if page == 1

    path = if page == 2
      "#{@locs[:paginator][:destination]}index.html"
    else
      "#{@locs[:paginator][:destination]}pages/#{page - 1}.html"
    end

    link_to 'Previous', path, **options
  end

  def next_page_link(options = {})
    page = @locs[:paginator][:page]
    path = "#{@locs[:paginator][:destination]}pages/#{page + 1}.html"
    return unless sitemap.find_resource_by_path(path)

    link_to 'Next', path, **options
  end
end
