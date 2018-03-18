require "middleman-core"

Middleman::Extensions.register :paginate_collection do
  require "middleman/paginate_collection"
  PaginateCollection
end
