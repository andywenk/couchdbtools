# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'couchdbtools/version'
require 'couchdbtools/config'

Gem::Specification.new do |spec|
  spec.name          = "couchdbtools"
  spec.version       = Couchdbtools::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Andy Wenk"]
  spec.email         = ["andy@nms.de"]
  spec.description   = %q{CouchDB Tools will make your life happy}
  spec.summary       = %q{CouchDB Tools}
  spec.homepage      = Couchdbtools::HOMEPAGE
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.6"
  spec.add_dependency "multi_json", "~> 1.3"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "reek"
end
