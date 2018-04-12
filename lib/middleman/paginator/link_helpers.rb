module Paginator::LinkHelpers
  def previous_page_link(options = {})
    page = @locs[:page]
    return if page == 1

    path = if page == 2
      "#{@locs[:destination]}index.html"
    else
      "#{@locs[:destination]}pages/#{page - 1}.html"
    end

    link_to 'Previous', path, **options
  end

  def next_page_link(options = {})
    page = @locs[:page]
    path = "#{@locs[:destination]}pages/#{page + 1}.html"
    return unless sitemap.find_resource_by_path(path)

    link_to 'Next', path, **options
  end
end
