# -*- encoding: utf-8 -*-
# stub: oj_serializers 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "oj_serializers".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/ElMassimo/oj_serializers/blob/master/CHANGELOG.md", "homepage_uri" => "https://github.com/ElMassimo/oj_serializers", "source_code_uri" => "https://github.com/ElMassimo/oj_serializers" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Maximo Mussini".freeze]
  s.date = "2020-11-07"
  s.description = "oj_serializers leverages the performance of the oj JSON serialization library, and minimizes object allocations, all while provding a similar API to Active Model Serializers.".freeze
  s.email = ["maximomussini@gmail.com".freeze]
  s.homepage = "https://github.com/ElMassimo/oj_serializers".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "A lighter JSON serializer for Ruby Objects in Rails. Easily migrate away from Active Model Serializers.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<oj>.freeze, [">= 3.8.0"])
  s.add_development_dependency(%q<actionpack>.freeze, [">= 4.0"])
  s.add_development_dependency(%q<railties>.freeze, [">= 4.0"])
end
