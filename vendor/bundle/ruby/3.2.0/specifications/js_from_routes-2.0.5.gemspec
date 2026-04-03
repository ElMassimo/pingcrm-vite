# -*- encoding: utf-8 -*-
# stub: js_from_routes 2.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "js_from_routes".freeze
  s.version = "2.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["M\u00E1ximo Mussini".freeze]
  s.date = "2021-09-02"
  s.description = "js_from_routes helps you by automatically generating path and API helpers from Rails route definitions, allowing you to save development effort and focus on the things that matter.".freeze
  s.email = ["maximomussini@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/ElMassimo/js_from_routes".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Generate JS automatically from Rails routes.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<railties>.freeze, [">= 5.1", "< 8"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2"])
  s.add_development_dependency(%q<listen>.freeze, ["~> 3.2"])
  s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.9"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
  s.add_development_dependency(%q<rspec-given>.freeze, ["~> 3.8"])
  s.add_development_dependency(%q<simplecov>.freeze, ["< 0.18"])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0"])
end
