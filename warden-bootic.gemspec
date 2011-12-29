# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'warden-bootic/version'

Gem::Specification.new do |s|
  s.name        = "warden-bootic"
  s.version     = Warden::Bootic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ismael Celis"]
  s.email       = ["ismael@bootic.net"]
  s.homepage    = "http://github.com/ismasan/warden-bootic"
  s.summary     = "A warden strategy for easy oauth integration with Bootic"
  s.description = s.summary

  s.rubyforge_project = "warden-bootic"

  s.add_dependency "json",   "~>1.5"
  s.add_dependency "warden", "~>1.0.4"
  s.add_dependency "oauth2", "~>0.4.1"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec",     "~>1.3.0"
  s.add_development_dependency "shotgun"
  s.add_development_dependency "bundler",   "~>1.0"
  s.add_development_dependency "addressable", "~>2.2.0"
  s.add_development_dependency "rack-test",   "~>0.5.3"
  s.add_development_dependency "ruby-debug"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
