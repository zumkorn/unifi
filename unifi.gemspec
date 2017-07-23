# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unifi/version'

Gem::Specification.new do |spec|
  spec.name          = "unifi"
  spec.version       = Unifi::VERSION
  spec.date          = '2017-07-23'
  spec.authors       = ["Sergey Korolev"]
  spec.email         = ["zumkorn@gmail.com"]

  spec.summary       = %q{A Ruby interface to UniFi Controller API}
  spec.description   = %q{A Ruby interface to UniFi Controller API.}
  spec.homepage      = "https://github.com/zumkorn/unifi"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty", "~> 0"
end
