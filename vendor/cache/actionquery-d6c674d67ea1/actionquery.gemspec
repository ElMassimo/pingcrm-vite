# -*- encoding: utf-8 -*-
# stub: actionquery 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "actionquery".freeze
  s.version = "0.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/ElMassimo/actionquery/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/ElMassimo/actionquery", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/ElMassimo/actionquery/tree/main" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Maximo Mussini".freeze]
  s.bindir = "exe".freeze
  s.date = "1980-01-02"
  s.description = "ActionQuery encapsulates query building in relation-backed objects instead of model scopes.".freeze
  s.email = ["maximomussini@gmail.com".freeze]
  s.files = [".mise.toml".freeze, ".rspec".freeze, ".rubocop.yml".freeze, "Appraisals".freeze, "CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "Gemfile".freeze, "Gemfile.lock".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "actionquery.gemspec".freeze, "docs/decisions/001-subclass-active-record-relation.md".freeze, "gemfiles/rails_7.2.gemfile".freeze, "gemfiles/rails_8.0.gemfile".freeze, "gemfiles/rails_8.1.gemfile".freeze, "lib/actionquery.rb".freeze, "lib/actionquery/base.rb".freeze, "lib/actionquery/error.rb".freeze, "lib/actionquery/search_query.rb".freeze, "lib/actionquery/version.rb".freeze, "sig/actionquery.rbs".freeze]
  s.homepage = "https://github.com/ElMassimo/actionquery".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1.0".freeze)
  s.rubygems_version = "4.0.20".freeze
  s.summary = "Keep your scopes and queries flexible by using Ruby".freeze

  s.installed_by_version = "4.0.20".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 7.2".freeze])
end
