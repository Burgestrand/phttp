# coding: utf-8
require File.expand_path("./lib/phttp/version", File.dirname(__FILE__))

Gem::Specification.new do |spec|
  spec.name          = "phttp"
  spec.version       = PHTTP::VERSION
  spec.authors       = ["Kim Burgestrand"]
  spec.email         = ["kim@burgestrand.se"]
  spec.summary       = %q{Parallel HTTP requests in pure Ruby!}
  spec.homepage      = "https://github.com/Burgestrand/phttp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nio4r"
  spec.add_dependency "http"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.beta1"
end
