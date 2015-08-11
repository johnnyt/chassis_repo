# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chassis/version"

Gem::Specification.new do |spec|
  spec.name          = "chassis"
  spec.version       = Chassis::VERSION
  spec.authors       = ["ahawkins"]
  spec.email         = ["adam@hawkins.io"]
  spec.description   = %q{A collection of modules and helpers for building mantainable Ruby applications}
  spec.summary       = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "interchange"
  spec.add_dependency "tnt"
  spec.add_dependency "lift"

  spec.add_dependency "prox"
  spec.add_dependency "logger-better"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "redis"
  spec.add_development_dependency "minitest", "= 5.4.2"
end
