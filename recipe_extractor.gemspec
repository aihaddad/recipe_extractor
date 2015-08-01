# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'recipe_extractor/version'

Gem::Specification.new do |spec|
  spec.name          = "recipe_extractor"
  spec.version       = RecipeExtractor::VERSION
  spec.authors       = ["Ahmed Elhaddad"]
  spec.email         = ["aihaddad@outlook.com"]
  spec.summary       = %q{Extracts the most relevant information from food recipe links}
  spec.description   = %q{RecipeExtractor aims to parse and extract food recipe meta information (e.g. title and description), as well as ingredients and directions from fairly well-written HTML5 pages & outputs them as a Ruby Hash.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"

  spec.add_runtime_dependency "metainspector"
  spec.add_runtime_dependency "mida"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "pismo"
end
