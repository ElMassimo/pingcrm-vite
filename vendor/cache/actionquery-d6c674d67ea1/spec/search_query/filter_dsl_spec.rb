# frozen_string_literal: true

RSpec.describe ActionQuery::SearchQuery, ".filter" do
  let(:base_query_class) { Class.new(described_class) { query_from User } }

  it "applies a callable filter in the query context" do
    base_query_class.filter :minimum_age, ->(value) { where(age: value..) }
    matching = User.create!(name: "Grace", age: 85)
    User.create!(name: "Ada", age: 37)

    expect(base_query_class.new.search(minimum_age: 80)).to contain_exactly(matching)
  end

  it "supports the :eq shorthand with a scalar" do
    base_query_class.filter :name, :eq
    ada = User.create!(name: "Ada")
    User.create!(name: "Grace")

    expect(base_query_class.new.search(name: "Ada")).to contain_exactly(ada)
  end

  it "supports the :eq shorthand with an array" do
    base_query_class.filter :name, :eq
    ada = User.create!(name: "Ada")
    grace = User.create!(name: "Grace")
    User.create!(name: "Linus")

    expect(base_query_class.new.search(name: %w[Ada Grace])).to contain_exactly(ada, grace)
  end

  it "returns no records for an empty :eq array" do
    base_query_class.filter :name, :eq
    User.create!(name: "Ada")

    expect(base_query_class.new.search(name: [])).to be_empty
  end

  it "turns other symbolic Arel operators into predicates" do
    base_query_class.filter :age, :gt
    matching = User.create!(name: "Grace", age: 85)
    User.create!(name: "Ada", age: 37)

    expect(base_query_class.new.search(age: 50)).to contain_exactly(matching)
  end

  it "normalizes string filter names" do
    base_query_class.filter "exact_name", ->(value) { where(name: value) }
    ada = User.create!(name: "Ada")

    expect(base_query_class.new.search(exact_name: "Ada")).to contain_exactly(ada)
  end

  it "rejects unknown symbolic operators at declaration time" do
    expect { base_query_class.filter(:age, :not_an_operator) }
      .to raise_error(ArgumentError, /Unknown operator for an Arel attribute/)
  end

  it "skips nil before invoking custom filters" do
    base_query_class.filter :explosive, ->(_) { raise "filter was invoked" }

    expect { base_query_class.new.search(explosive: nil) }.not_to raise_error
  end

  it "passes false values to custom filters" do
    base_query_class.filter :enabled, ->(value) { where(active: value) }
    inactive = User.create!(name: "Ada", active: false)
    User.create!(name: "Grace", active: true)

    expect(base_query_class.new.search(enabled: false)).to contain_exactly(inactive)
  end

  describe "inheritance" do
    it "inherits parent filters" do
      base_query_class.filter :exact_name, ->(value) { where(name: value) }
      child = Class.new(base_query_class)
      ada = User.create!(name: "Ada")

      expect(child.new.search(exact_name: "Ada")).to contain_exactly(ada)
    end

    it "does not leak child filters into parents or siblings" do
      child = Class.new(base_query_class)
      sibling = Class.new(base_query_class)
      child.filter :exact_name, ->(value) { where(name: value) }

      expect(child.search_filters).to have_key(:exact_name)
      expect(base_query_class.search_filters).not_to have_key(:exact_name)
      expect(sibling.search_filters).not_to have_key(:exact_name)
    end
  end
end
