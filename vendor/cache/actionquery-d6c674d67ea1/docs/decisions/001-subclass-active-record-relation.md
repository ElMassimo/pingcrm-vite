# ADR-001: Subclass ActiveRecord::Relation

## Status

Accepted

## Date

2026-09-21

## Context

Queryable-style query objects usually wrap a relation and delegate selected methods. That requires maintaining lists of chainable and terminal methods, and a wrapper can stop behaving like a native relation when Active Record adds APIs.

ActionQuery is intended specifically for Active Record. Its query objects need to compose with scopes, association queries, calculations, connection management, and third-party instrumentation as relations rather than relation-like wrappers.

## Decision

`ActionQuery::Base` subclasses `ActiveRecord::Relation`. Query classes add behavior with ordinary instance methods, and Relation cloning preserves the query subclass through normal chains.

A configured relation source is decomposed into its model, table, predicate builder, and relation values. The relation itself is never installed as Active Record's model.

ActionQuery explicitly delegates the model and connection methods used by supported Relation versions. A real-database test suite runs against the minimum Rails version and each currently supported minor line.

## Alternatives considered

### Wrap and delegate an internal relation

This is the approach used by Queryable. It has a smaller dependency on Relation initialization internals, but it requires classifying Active Record methods as chainable or terminal and can return wrapper-breaking values when that classification becomes stale.

### Extend each relation with a module

`relation.extending(Module)` avoids subclass construction but makes named query inheritance, model inference, and class-level filter configuration less direct. It also changes the API from constructing a query object to decorating every source relation.

## Consequences

- Query objects pass `is_a?(ActiveRecord::Relation)` and work with native relation APIs.
- Relation methods naturally retain custom query methods after chaining.
- ActionQuery is intentionally coupled to supported Active Record Relation internals.
- New Rails minor versions must be added to CI before being claimed as supported.
- Connection, query-cache, scope delegation, and relation-source initialization need dedicated regression tests.
