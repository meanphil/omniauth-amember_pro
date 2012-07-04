# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-amember_pro/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Phil Murray"]
  gem.email         = ["pmurray@nevada.net.nz"]
  gem.description   = %q{OmniAuth strategy for Open2view REST Auth}
  gem.summary       = %q{OmniAuth strategy for Open2view REST Auth}
  gem.homepage      = "https://www.nevada.net.nz/"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-amember_pro"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::AMemberPro::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'faraday'
  gem.add_dependency 'multi_json'
end
