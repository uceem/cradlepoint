# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cradlepoint/version'

Gem::Specification.new do |spec|
  spec.name          = "cradlepoint"
  spec.version       = Cradlepoint::VERSION
  spec.authors       = ["uceem"]
  spec.email         = ["support@uceem.com"]
  spec.description   = %q{Cradlepoint ECM API gem}
  spec.summary       = %q{Cradlepoint ECM API gem}
  spec.homepage      = "https://www.uceem.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client'
  spec.add_dependency 'json'

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
