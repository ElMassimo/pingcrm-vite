# frozen_string_literal: true

RSpec.describe ActionQuery::Base, "delegation" do
  subject(:query) { query_class.new }

  let(:query_class) { Class.new(described_class) { query_from User } }

  describe "model metadata" do
    it "exposes the configured model class" do
      expect(query.model_class).to equal(User)
    end

    it "delegates SQL sanitization" do
      expect(query.sanitize_sql_like("100%_real")).to eq(User.sanitize_sql_like("100%_real"))
    end

    it "delegates column and attribute metadata" do
      expect(query.columns_hash).to equal(User.columns_hash)
      expect(query.attribute_types).to equal(User.attribute_types)
      expect(query.primary_key).to eq(User.primary_key)
    end

    it "uses the model logger without requiring Rails" do
      expect(query.logger).to equal(User.logger)
    end

    it "exposes the query class name for instrumentation" do
      stub_const("InstrumentedUsersQuery", query_class)

      expect(InstrumentedUsersQuery.new.name).to eq("InstrumentedUsersQuery")
    end
  end

  describe "connection management" do
    it "delegates the adapter class" do
      expect(query.adapter_class).to equal(User.adapter_class)
    end

    it "supports relation internals that call the adapter class" do
      User.create!(name: "Ada")

      expect(query.cache_key).to start_with("users/query-")
    end

    it "delegates the connection pool" do
      expect(query.connection_pool).to equal(User.connection_pool)
    end

    it "delegates leased and legacy connections" do
      expect(query.lease_connection).to equal(User.lease_connection)
      expect(query.connection).to equal(User.connection)
    end

    it "yields and returns through with_connection" do
      yielded_connection = nil

      returned = query.with_connection do |connection|
        yielded_connection = connection
        :from_block
      end

      expect(yielded_connection).to equal(User.lease_connection)
      expect(returned).to eq(:from_block)
    end

    it "uses real uncached semantics" do
      User.cache do
        expect(User.connection.query_cache_enabled).to be(true)
        expect(query.uncached { User.connection.query_cache_enabled }).to be(false)
        expect(User.connection.query_cache_enabled).to be(true)
      end
    end
  end

  describe "model scopes" do
    it "reports that it responds to model scopes" do
      expect(query).to respond_to(:active, :named, :with_minimum_age)
      expect(query).not_to respond_to(:not_a_scope)
    end

    it "calls a scope while preserving the current relation" do
      scoped = query.where(name: "Ada").active

      expect(scoped).to be_a(query_class)
      expect(scoped.where_values_hash).to include("name" => "Ada", "active" => true)
    end

    it "forwards positional and keyword arguments" do
      expect(query.named("Ada").where_values_hash).to include("name" => "Ada")
      expect(query.with_minimum_age(age: 21).to_sql).to include(">= 21")
    end

    it "forwards blocks" do
      scoped = query.where(active: true).transform_scope { |relation| relation.where(age: 21) }

      expect(scoped).to be_a(query_class)
      expect(scoped.where_values_hash).to include("active" => true, "age" => 21)
    end

    it "preserves normal missing-method errors" do
      expect { query.not_a_scope }.to raise_error(NoMethodError, /not_a_scope/)
    end
  end
end
