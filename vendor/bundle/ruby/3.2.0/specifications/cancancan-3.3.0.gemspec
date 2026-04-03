# -*- encoding: utf-8 -*-
# stub: cancancan 3.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cancancan".freeze
  s.version = "3.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "funding_uri" => "https://github.com/sponsors/coorasse" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alessandro Rodi (Renuo AG)".freeze, "Bryan Rite".freeze, "Ryan Bates".freeze, "Richard Wilson".freeze]
  s.date = "2021-06-21"
  s.description = "Simple authorization solution for Rails. All permissions are stored in a single location.".freeze
  s.email = "alessandro.rodi@renuo.ch".freeze
  s.homepage = "https://github.com/CanCanCommunity/cancancan".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Simple authorization solution for Rails.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<appraisal>.freeze, [">= 2.0.0", "~> 2.0"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.1", ">= 10.1.1"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 3.2.0", "~> 3.2"])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.63.1"])
end
