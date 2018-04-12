require "middleman-core"

Middleman::Extensions.register :paginator do
  require 'middleman/link_helpers'
  require 'middleman/paginator'

  Paginator
end
