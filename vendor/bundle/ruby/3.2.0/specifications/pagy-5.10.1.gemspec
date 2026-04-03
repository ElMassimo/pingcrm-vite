# -*- encoding: utf-8 -*-
# stub: pagy 5.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "pagy".freeze
  s.version = "5.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/ddnexus/pagy/issues", "changelog_uri" => "https://github.com/ddnexus/pagy/blob/master/CHANGELOG.md", "documentation_uri" => "https://ddnexus.github.io/pagy", "homepage_uri" => "https://github.com/ddnexus/pagy", "live_support" => "https://gitter.im/ruby-pagy/Lobby", "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Domizio Demichelis".freeze]
  s.date = "2022-02-03"
  s.description = "Agnostic pagination in plain ruby. It does it all. Better.".freeze
  s.email = ["dd.nexus@gmail.com".freeze]
  s.homepage = "https://github.com/ddnexus/pagy".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.4.20".freeze
  s.summary = "The kick-ass pagination ruby gem".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
end
