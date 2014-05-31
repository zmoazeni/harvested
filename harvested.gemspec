# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvest/version'

Gem::Specification.new do |spec|
  spec.name          = "harvested"
  spec.version       = Harvest::VERSION
  spec.authors       = ["Zach Moazeni"]
  spec.email         = ["zach.moazeni@gmail.com"]
  spec.summary      = "A Ruby Wrapper for the Harvest API http://www.getharvest.com/"
  spec.description   = "Harvested wraps the Harvest API concisely without the use of Rails dependencies. More information about the Harvest API can be found on their website (http://www.getharvest.com/api). For support hit up the Mailing List (http://groups.google.com/group/harvested)"
  spec.homepage      = "http://github.com/zmoazeni/harvested"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_runtime_dependency('httparty')
  spec.add_runtime_dependency('hashie', '~> 1')
  spec.add_runtime_dependency('json')
end
