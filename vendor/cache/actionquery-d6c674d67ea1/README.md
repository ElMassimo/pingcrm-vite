# ActionQuery

[![Gem Version](https://badge.fury.io/rb/actionquery.svg)](https://badge.fury.io/rb/actionquery)
[![CI](https://github.com/ElMassimo/actionquery/actions/workflows/main.yml/badge.svg)](https://github.com/ElMassimo/actionquery/actions/workflows/main.yml)
[![Ruby](https://img.shields.io/badge/Ruby-%3E%3D%203.1-CC342D.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-%3E%3D%207.2-D30001.svg)](https://rubyonrails.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.txt)

ActionQuery lets you define query objects with ordinary Ruby methods while retaining the full behavior of `ActiveRecord::Relation`.

It follows the spirit of [Queryable](https://github.com/ElMassimo/queryable), but is designed specifically for modern Active Record. Instead of wrapping a relation and maintaining lists of delegated and chainable methods, an ActionQuery **is** a relation.

## Query methods

Define reusable query behavior as instance methods:

```ruby
class CustomersQuery < ActionQuery::Base
  def active
    where(status: "active")
  end

  def recently_logged_in
    where(logged_in_at: 1.week.ago..)
  end

  def favourite_brand(product, brand)
    where(favourite_product: product, favourite_brand: brand)
  end
end

CustomersQuery.new
  .active
  .recently_logged_in
  .favourite_brand(:beer, "Miller")
```

Relation methods such as `where`, `joins`, `includes`, `order`, `limit`, calculations, and record loading work normally. Chained relations retain the query class and its methods—there is no `scope`, `chain`, or `delegate_and_chain` declaration.

## Model scopes and delegation

Model scopes and public model query methods are available from a query object. They execute inside the current relation scope:

```ruby
class Customer < ApplicationRecord
  scope :verified, -> { where(verified: true) }
end

CustomersQuery.new
  .where(shop: current_shop)
  .verified
  .recently_logged_in
```

ActionQuery also delegates the model metadata, query-cache, logging, and connection methods required by Active Record internals, including `adapter_class`, `connection_pool`, `primary_key`, `lease_connection`, and `with_connection`.

## Advantages

- Query objects use plain Ruby methods, inheritance, and modules.
- Queries compose with model scopes and standard Active Record relations.
- Chaining does not depend on maintaining a list of Relation methods.
- Query behavior stays out of models without introducing a repository abstraction.
- Search filters and sorting strategies can be inherited and extended safely.
- Compatibility is tested against every supported Rails minor line.

## Installation

Add ActionQuery to your bundle:

```ruby
gem "actionquery"
```

Then run:

```sh
bundle install
```

ActionQuery requires Ruby 3.1 or newer and Active Record 7.2 or newer. It depends on `activerecord`, not the full `rails` gem.

## Basic usage

### Model inference

ActionQuery removes `Query` or `SearchQuery`, singularizes the remainder, and resolves the model:

```ruby
class CustomersQuery < ActionQuery::Base
end

CustomersQuery.new.model # => Customer
```

Namespaced models are preferred, with a top-level fallback:

```ruby
class Admin::CustomersQuery < ActionQuery::Base
end

Admin::CustomersQuery.new.model
# => Admin::Customer when defined, otherwise Customer
```

### Explicit query sources

Use `query_from` when naming inference is not appropriate. It accepts a model or an existing relation:

```ruby
class RecentCustomersQuery < ActionQuery::Base
  query_from Customer.where(created_at: 30.days.ago..).order(created_at: :desc)
end
```

A relation source retains its clauses while keeping `Customer` as the Active Record model. The source relation is not mutated.

### Wrapping a relation

Use `.wrap` to convert an existing relation into a particular query class:

```ruby
RecentCustomersQuery.wrap(shop.customers.where(status: "active"))
```

## Search queries

`ActionQuery::SearchQuery` adds conventions for common search forms:

```ruby
class CustomersSearchQuery < ActionQuery::SearchQuery
end

CustomersSearchQuery.new.search(
  name: "miller",
  active: true,
  status: :invited
)
```

Default filtering is based on the column type:

| Column type | Behavior |
| --- | --- |
| string, text | Escaped, case-insensitive partial match |
| integer, decimal, boolean, date | Exact Active Record condition |
| enum | Exact enum match |
| datetime + `Date` | Entire calendar day |
| datetime + `Time` or `DateTime` | Exact value |

Nil conditions and `sort` metadata are ignored. Unsupported or unknown fields raise `NotImplementedError` instead of silently producing an unintended query.

### Custom filters

Define a filter with a callable executed in the query context:

```ruby
class CustomersSearchQuery < ActionQuery::SearchQuery
  filter :minimum_age, ->(age) { where(age: age..) }
  filter :email, :eq
  filter :older_than, :gt
end
```

`:eq` uses Active Record hash conditions, so it supports a scalar or an array. Other symbols must name an `Arel::Attributes::Attribute` operator.

Use `matches_any_of` for escaped partial matching across columns:

```ruby
class CustomersSearchQuery < ActionQuery::SearchQuery
  filter :general, ->(value) {
    matches_any_of(%i[first_name last_name email], value)
  }
end
```

Filter definitions are inherited. Adding a filter to a child query does not modify its parent or sibling classes.

### Sorting

`apply_sorting` accepts any object responding to `strategy` and `direction`:

```ruby
SortOption = Struct.new(:strategy, :direction, keyword_init: true)
option = SortOption.new(strategy: :created_at, direction: :desc)

CustomersSearchQuery.new.apply_sorting(option)
```

Unconfigured strategies use Active Record's hash-based `order`. Define a custom strategy for computed or joined values:

```ruby
class CustomersSearchQuery < ActionQuery::SearchQuery
  sort_by :seniority, ->(direction) { order(hired_at: direction) }
end
```

Active Record validates default sort directions. Custom strategies are responsible for safely handling any SQL fragments they introduce.

## Query helpers

`ActionQuery::Base` includes a small set of composable helpers:

```ruby
query.any_of(Customer.arel_table[:role].eq("admin"), Customer.arel_table[:owner].eq(true))
query.scope_if(include_archived) { |relation| relation.unscope(where: :archived_at) }
query.paginate(page_number: 2, page_size: 25)
query.unsorted
query.union(Customer.where(invited: true))
```

`distinct` keeps Active Record's normal behavior unless given a column symbol:

```ruby
query.distinct                # a SELECT DISTINCT relation
query.distinct(false)         # a relation without SELECT DISTINCT
query.distinct(:country_code) # an eager array of unique values
```

Search queries also provide `with_ids(ids)` and `all_attributes` for primary-key filtering and resetting a previous `select`.

## Compatibility notes

Subclassing `ActiveRecord::Relation` provides native composition but intentionally couples ActionQuery to Relation initialization and delegation behavior. The suite exercises real database queries on Rails 7.2, 8.0, and 8.1, including connection methods and query-cache semantics.

See [ADR-001](docs/decisions/001-subclass-active-record-relation.md) for the rationale and alternatives considered.

## Development

The repository uses [mise](https://mise.jdx.dev/) for Ruby and Bundler for dependencies. Local development targets Ruby 4 and Rails 8.1:

```sh
mise install
bin/setup
bundle exec rake
```

Run an individual Rails appraisal with:

```sh
bundle exec appraisal rails-7.2 rspec
bundle exec appraisal rails-8.0 rspec
bundle exec appraisal rails-8.1 rspec
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/ElMassimo/actionquery. Behavioral changes should include regression tests against real Active Record relations.

## License

ActionQuery is available under the [MIT License](LICENSE.txt).
