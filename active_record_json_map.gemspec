# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_record_json_map/version"

Gem::Specification.new do |spec|
  spec.name          = "active_record_json_map"
  spec.version       = ActiveRecordJsonMap::VERSION
  spec.authors       = ["Tatumaki"]
  spec.email         = ["tatumaki.x.euphoric@gmail.com"]

  spec.summary       = %q{ActiveRecordJsonMap let render json recursively from ActiveRecord::Relation.}
  spec.description   = %q{Build json }
  spec.homepage      = "https://github.com/Tatumaki/active_record_json_map"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "activerecord"
end
