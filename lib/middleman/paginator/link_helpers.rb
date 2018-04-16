require 'middleman/paginator/pages_group'

module Paginator::LinkHelpers
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

  def pages(count: 5)
    pages_group = Paginator::PagesGroup.new(
      current: @locs[:paginator][:page], last: @locs[:paginator][:last_page], count: count
    )

    pages_group.generate do |page_number|
      page_name = page_number == 1 ? 'index.html' : "pages/#{page_number}.html"
      path = @locs[:paginator][:destination] + page_name

      yield(page_number, path)
    end
  end
end
