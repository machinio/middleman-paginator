# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-paginator"
  s.version     = "0.0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TheSmartnik"]
  s.email       = ["misharinn@gmail.com"]
  s.homepage    = "https://github.com/TheSmartnik/middleman-paginator"
  s.summary     = %q{A simple plugin to allow pagination in middleman}
  s.description = %q{A simple way to paginate any collection in middleman }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])
end
