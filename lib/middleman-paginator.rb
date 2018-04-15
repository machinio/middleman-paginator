require "middleman-core"

Middleman::Extensions.register :paginator do
  require 'middleman/paginator'

  Paginator::Core
end
