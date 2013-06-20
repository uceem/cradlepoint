# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cradlepointr/version'

Gem::Specification.new do |spec|
  spec.name          = "cradlepointr"
  spec.version       = Cradlepointr::VERSION
  spec.authors       = ["johnotander"]
  spec.email         = ["johnotander@gmail.com"]
  spec.description   = %q{Cradlepoint ECM API gem}
  spec.summary       = %q{Cradlepoint ECM API gem}
  spec.homepage      = "http://www.uceem.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end