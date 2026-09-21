# frozen_string_literal: true

RSpec.describe ActionQuery::Base do
  describe ".new" do
    it "cannot instantiate the abstract base query" do
      expect { described_class.new }
        .to raise_error(NotImplementedError, /ActionQuery::Base is an abstract query/)
    end

    it "uses an explicitly configured model" do
      query_class = Class.new(described_class) { query_from User }

      query = query_class.new

      expect(query).to be_a(ActiveRecord::Relation)
      expect(query.model).to equal(User)
      expect(query.klass).to equal(User)
      expect(query.table.name).to eq("users")
    end

    it "preserves the query subclass while chaining relation methods" do
      query_class = Class.new(described_class) { query_from User }

      query = query_class.new.where(active: true).order(:name)

      expect(query).to be_a(query_class)
      expect(query.where_clause).not_to be_empty
      expect(query.order_values).not_to be_empty
    end

    it "starts from a configured relation without mutating it" do
      source = User.where(active: true).order(name: :desc)
      query_class = Class.new(described_class) { query_from source }

      query = query_class.new.where(age: 21)

      expect(query.model).to equal(User)
      expect(query.where_values_hash).to include("active" => true, "age" => 21)
      expect(query.order_values).to eq(source.order_values)
      expect(source.where_values_hash).to eq("active" => true)
    end

    it "inherits an explicitly configured source" do
      parent = Class.new(described_class) { query_from User.where(active: true) }
      child = Class.new(parent)

      expect(child.new.where_values_hash).to eq("active" => true)
    end
  end

  describe "model inference" do
    it "infers a model from a plural query name" do
      stub_const("UsersQuery", Class.new(described_class))

      expect(UsersQuery.new.model).to equal(User)
    end

    it "removes the SearchQuery suffix" do
      stub_const("UsersSearchQuery", Class.new(described_class))

      expect(UsersSearchQuery.new.model).to equal(User)
    end

    it "prefers a model in the query namespace" do
      stub_const("Admin::UsersQuery", Class.new(described_class))

      expect(Admin::UsersQuery.new.model).to equal(Admin::User)
    end

    it "falls back to a top-level model" do
      stub_const("Backoffice", Module.new)
      stub_const("Backoffice::UsersQuery", Class.new(described_class))

      expect(Backoffice::UsersQuery.new.model).to equal(User)
    end

    it "reports an actionable error when no model can be inferred" do
      stub_const("MissingRecordsQuery", Class.new(described_class))

      expect { MissingRecordsQuery.new }
        .to raise_error(NotImplementedError, /specify one with `query_from`/)
    end

    it "reports an actionable error for an anonymous unconfigured query" do
      query_class = Class.new(described_class)

      expect { query_class.new }
        .to raise_error(NotImplementedError, /specify one with `query_from`/)
    end
  end

  describe ".wrap" do
    it "returns the supplied relation as the query subclass" do
      query_class = Class.new(described_class) { query_from User }
      relation = User.where(active: true).order(:name).limit(2)

      wrapped = query_class.wrap(relation)

      expect(wrapped).to be_a(query_class)
      expect(wrapped.to_sql).to eq(relation.to_sql)
    end
  end
end
