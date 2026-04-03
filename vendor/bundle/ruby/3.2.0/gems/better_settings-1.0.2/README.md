<h1 align="center">
Better Settings
<p align="center">
  <a href="https://github.com/ElMassimo/better_settings/actions">
    <img alt="Build Status" src="https://github.com/ElMassimo/better_settings/workflows/build/badge.svg"/>
  </a>
  <a href="https://codeclimate.com/github/ElMassimo/better_settings">
    <img alt="Maintainability" src="https://codeclimate.com/github/ElMassimo/better_settings/badges/gpa.svg"/>
  </a>
  <a href="https://codeclimate.com/github/ElMassimo/better_settings">
    <img alt="Test Coverage" src="https://codeclimate.com/github/ElMassimo/better_settings/badges/coverage.svg"/>
  </a>
  <a href="https://rubygems.org/gems/better_settings">
    <img alt="Gem Version" src="https://img.shields.io/gem/v/better_settings.svg?colorB=e9573f"/>
  </a>
  <a href="https://github.com/ElMassimo/better_settings/blob/master/LICENSE.txt">
    <img alt="License" src="https://img.shields.io/badge/license-MIT-428F7E.svg"/>
  </a>
</p>
</h1>

A robust settings library for Ruby. Access your settings by calling methods on a safe immutable object.

## Features ⚡️

- 🚀 __Light and Performant:__ settings are eagerly loaded, no `method_missing` tricks, no dependencies.
- 💬 __Useful Error Messages:__ when trying to access a setting that does not exist.
- 💎 __Immutability:__ once created settings can't be modified.
- 🗂 __Multiple Files:__ useful to create multiple environment-specific source files.
- ❕ __No Optional Setings:__ since it encourages unsafe access patterns.

You can read more about it in [the blog announcement](https://maximomussini.com/posts/better-settings/).


## Installation 💿

Add this line to your application's Gemfile:

```ruby
gem 'better_settings'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_settings

## Usage 🚀

### 1. Define a class

Create a class in your application that extends `BetterSettings`:

```ruby
# app/models/settings.rb
class Settings < BetterSettings
  source Rails.root.join('config', 'application.yml'), namespace: Rails.env
end
```

We use `Rails.root` in this example to obtain an absolute path to a plain YML file,
but when using other Ruby frameworks you can use `File.expand_path` with `__dir__` instead.

Also, we specified a `namespace` with the current environment. You can provide
any value that corresponds to a key in the YAML file that you want to use.
This allows to target different environments with the same file.

### 2. Create your settings

Now, create a YAML file that contains all the possible namespaces:

```yaml
# config/application.yml
defaults: &defaults
  port: 80
  mailer:
    root: www.example.com
  dynamic: <%= "Did you know you can use ERB inside the YML file? Env is #{ Rails.env }." %>

development:
  <<: *defaults
  port: 3000

test:
  <<: *defaults

production:
  <<: *defaults
```

The `defaults` group in this example won't be used directly, we are using YAML's
syntax to reuse those values when we use `<<: *defaults`, allowing us to share
these values across environments.

### 3. Access your settings

You can use these settings anywhere, for example in a model:

```ruby
class Post < ActiveRecord::Base
  self.per_page = Settings.pagination.posts_per_page
end
```

or in the console:

```
>> Rails.env
=> "development"

>> Settings.mailer
=> "#<Settings ... >"

>> Settings.mailer.root
=> "www.example.com

>> Settings.port
=> 3000

>> Settings.dynamic
=> "Did you know you can use ERB inside the YML file? Env is development."
```

## Advanced Setup ⚙

You can create as many setting classes as you need, and name them in different ways, and read from as many files as necessary (nested keys will be merged).

The way I like to use it, is by reading a few optional files for the _development_ and _test_ environments, which allows each developer to override some settings in their own local environment (and git ignoring `development.yml` and `test.yml`).

```ruby
# app/models/settings.rb
class Settings < BetterSettings
  source Rails.root.join('config/application.yml'), namespace: Rails.env
  source Rails.root.join('config/development.yml'), namespace: Rails.env, optional: true if Rails.env.development?
  source Rails.root.join('config/test.yml'), namespace: Rails.env, optional: true if Rails.env.test?
end
```

Then `application.yml` looks like this:

```yaml
# application.yml
defaults: &defaults
  auto_logout: false
  secret_key_base: 'fake_secret_key_base'

server_defaults: &server_defaults
  <<: *defaults
  auto_logout: true
  secret_key: <%= ENV['SECRET_KEY'] %>

development:
  <<: *defaults
  host: 'localhost'

test:
  <<: *defaults
  host: '127.0.0.1'

staging:
  <<: *server_defaults
  host: 'staging.example.com'

production:
  <<: *server_defaults
  host: 'example.com'
```

A developer might want to override some settings by defining a `development.yml` such as:

```yaml
development:
  auto_logout: true
````

The main advantage is that those changes won't be tracked in source control :smiley:
