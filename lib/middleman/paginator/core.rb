class Paginator::Core < ::Middleman::ConfigExtension
  helpers Paginator::LinkHelpers

  self.resource_list_manipulator_priority = 0

  expose_to_config :paginate

  option :per_page, 20, 'Controls pagination'

  CollectionProxyDescriptor = Struct.new(:descriptors) do
    def execute_descriptor(app, resources)
      descriptors.reduce(resources) do |resources, descriptor|
        if descriptor.metadata[:ignore]
          d = ::Middleman::Sitemap::Extensions::Ignores::StringIgnoreDescriptor.new(descriptor.target)
          d.execute_descriptor(app, resources)
        end

        descriptor.execute_descriptor(app, resources)
      end
    end
  end

  def paginate(destination:, objects:, template:, **page_options)
    descriptors = []

    pages = objects.each_slice(options.per_page)
    pages.with_index(1).reverse_each do |o, i|
      paginate_options = { objects: o, page: i, destination: destination , last_page: pages.count }
      path = i == 1 ? 'index.html' : "pages/#{i}.html"

      descriptor = Middleman::Sitemap::Extensions::ProxyDescriptor.new(
        ::Middleman::Util.normalize_path("#{destination}#{path}"),
        ::Middleman::Util.normalize_path(template),
        page_options.merge(locals: { paginator: paginate_options }) { |key, v1, v2| v1.merge v2 }
      )

      descriptors << descriptor
    end

    CollectionProxyDescriptor.new(descriptors)
  end
end

