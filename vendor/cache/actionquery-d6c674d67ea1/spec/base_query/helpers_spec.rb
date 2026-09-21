# frozen_string_literal: true

RSpec.describe ActionQuery::Base, "relation helpers" do
  subject(:query) { query_class.new }

  let(:query_class) { Class.new(described_class) { query_from User } }

  describe "#any_of" do
    it "returns itself when no conditions are provided" do
      expect(query.any_of).to equal(query)
    end

    it "applies one condition" do
      ada = User.create!(name: "Ada", age: 37)
      User.create!(name: "Grace", age: 85)

      expect(query.any_of(User.arel_table[:age].eq(37))).to contain_exactly(ada)
    end

    it "combines multiple conditions with OR" do
      ada = User.create!(name: "Ada", age: 37)
      grace = User.create!(name: "Grace", age: 85)
      User.create!(name: "Linus", age: 54)

      conditions = [User.arel_table[:age].eq(37), User.arel_table[:name].eq("Grace")]

      expect(query.any_of(*conditions)).to contain_exactly(ada, grace)
    end
  end

  describe "#paginate" do
    before do
      5.times { |index| User.create!(name: "User #{index}") }
    end

    it "returns itself when page size is nil" do
      expect(query.paginate(page_number: 1, page_size: nil)).to equal(query)
    end

    it "returns the requested page" do
      ordered = query.order(:id)

      expect(ordered.paginate(page_number: 1, page_size: 2).pluck(:name)).to eq(["User 0", "User 1"])
      expect(ordered.paginate(page_number: 2, page_size: 2).pluck(:name)).to eq(["User 2", "User 3"])
      expect(ordered.paginate(page_number: 3, page_size: 2).pluck(:name)).to eq(["User 4"])
    end
  end

  describe "#scope_if" do
    it "yields and returns the resulting relation for a truthy condition" do
      scoped = query.scope_if(true) { |relation| relation.where(active: true) }

      expect(scoped.where_values_hash).to include("active" => true)
    end

    it "does not yield and returns itself for a falsey condition" do
      expect { |block| query.scope_if(false, &block) }.not_to yield_control
      expect(query.scope_if(nil) { raise "not reached" }).to equal(query)
    end
  end

  describe "#unsorted" do
    it "removes ordering while preserving other clauses" do
      scoped = query.where(active: true).order(:name).limit(3).unsorted

      expect(scoped.order_values).to be_empty
      expect(scoped.where_values_hash).to include("active" => true)
      expect(scoped.limit_value).to eq(3)
    end
  end

  describe "#distinct" do
    it "retains Active Record's no-argument behavior" do
      expect(query.distinct.distinct_value).to be(true)
      expect(query.distinct(false).distinct_value).to be(false)
    end

    it "returns unique column values when passed a symbol" do
      User.create!(name: "Ada", age: 37)
      User.create!(name: "Grace", age: 37)
      User.create!(name: "Linus", age: 54)

      expect(query.distinct(:age)).to contain_exactly(37, 54)
    end
  end

  describe "#union" do
    it "combines compatible relations and remains chainable" do
      ada = User.create!(name: "Ada", active: true, age: 37)
      grace = User.create!(name: "Grace", active: false, age: 85)
      User.create!(name: "Linus", active: false, age: 54)

      union = query.where(active: true).union(User.where(age: 85))

      expect(union).to be_a(query_class)
      expect(union.order(:name)).to contain_exactly(ada, grace)
    end
  end
end
