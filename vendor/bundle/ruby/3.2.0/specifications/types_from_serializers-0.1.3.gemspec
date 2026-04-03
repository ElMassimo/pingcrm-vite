# -*- encoding: utf-8 -*-
# stub: types_from_serializers 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "types_from_serializers".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["M\u00E1ximo Mussini".freeze]
  s.date = "2022-07-12"
  s.description = "types_from_serializers helps you by automatically generating TypeScript interfaces for your JSON serializers, allowing you typecheck your frontend code to ship fast and with confidence.".freeze
  s.email = ["maximomussini@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/ElMassimo/types_from_serializers".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Generate TypeScript interfaces from your JSON serializers.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<railties>.freeze, [">= 5.1", "< 8"])
  s.add_runtime_dependency(%q<oj_serializers>.freeze, ["~> 1.0"])
  s.add_runtime_dependency(%q<listen>.freeze, ["~> 3.2"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2"])
  s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.9"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13"])
  s.add_development_dependency(%q<rspec-given>.freeze, ["~> 3.8"])
  s.add_development_dependency(%q<rspec-snapshot>.freeze, [">= 0"])
  s.add_development_dependency(%q<simplecov>.freeze, ["< 0.18"])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0"])
  s.add_development_dependency(%q<activerecord>.freeze, [">= 0"])
  s.add_development_dependency(%q<js_from_routes>.freeze, [">= 0"])
  s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop-rails>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop-rspec>.freeze, [">= 0"])
  s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0"])
end
