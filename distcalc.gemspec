# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distcalc/version'

Gem::Specification.new do |spec|
  spec.name          = "distcalc"
  spec.version       = Distcalc::VERSION
  spec.authors       = ["Diego Lins",
                        "Eduardo Seffair",
                        "Emiliano Firmino",
                        "Francisca Maia",
                        "João Guilherme Martinez"]
  spec.email         = ["diego.lins.freitas@gmail.com",
                        "eduardoseffairfilho@gmail.com",
                        "emiliano.firmino@gmail.com",
                        "maiaaugus@gmail.com",
                        "joao.guilherme.martinez@gmail.com"]
  spec.description   = %q{Distributed Ruby Calculator}
  spec.summary       = %q{A simple distributed calculator for basic arithmetic.
                          Resolve simple math expression of +,-,*,/ with () to enforce
                          precedence.}
  spec.homepage      = "https://github.com/Miliox/distcalc"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
