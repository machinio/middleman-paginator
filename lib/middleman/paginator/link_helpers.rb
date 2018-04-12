module Paginator::LinkHelpers
  PAGES_COUNT = 5

  def previous_page_link(text: 'Previous', **options)
    page = @locs[:paginator][:page]
    return if page == 1

    path = if page == 2
      "#{@locs[:paginator][:destination]}index.html"
    else
      "#{@locs[:paginator][:destination]}pages/#{page - 1}.html"
    end

    link_to text, path, **options
  end

  def next_page_link(text: 'Next', **options)
    page = @locs[:paginator][:page]
    path = "#{@locs[:paginator][:destination]}pages/#{page + 1}.html"
    return unless sitemap.find_resource_by_path(path)

    link_to text, path, **options
  end

  def last_page_link(text: 'Last', **options)
    page = @locs[:paginator][:last_page]

    path = "#{@locs[:paginator][:destination]}pages/#{page + 1}.html"

    link_to text, path, **options
  end

  def first_page_link(text: 'First', **options)
    path = "#{@locs[:paginator][:destination]}index.html"

    link_to text, path, **options
  end

  def pages(**options)
    last = @locs[:paginator][:last_page]
    current = @locs[:paginator][:page]
    spread = 2

    first_page = current <= 2 : 1 ? current - spread
    last_page = current >= last - spread ? last : current + spread

    (first_page..last_page).map do |page_number|
      link_to_page(page: page_number, **options)
    end
  end

  def link_to_page(page:, text: page, **options)
    page_name = page == 1 ? "index.html" : "#{page}.html"
    path = "#{@locs[:paginator][:destination]}#{page_name}"

    link_to text, path, **options
  end
end
