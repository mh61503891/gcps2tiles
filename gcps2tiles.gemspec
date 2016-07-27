# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gcps2tiles/version'

Gem::Specification.new do |spec|
  spec.name          = 'gcps2tiles'
  spec.version       = GCPS2TILES::VERSION
  spec.authors       = ['mh61503891']
  spec.email         = ['mh.on.web@gmail.com']

  spec.summary       = %q{A generator of TMS (Tile Map Service) tiles from a image and its GCPs (Ground Control Points).}
  spec.description   = %q{A generator of TMS (Tile Map Service) tiles from a image and its GCPs (Ground Control Points).}
  spec.homepage      = 'https://github.com/mh61503891/gcps2tiles'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'proj4rb'
  spec.add_dependency 'memoizable'
  spec.add_dependency 'thor'
  spec.add_dependency 'systemu'
  spec.add_dependency 'colorize'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
