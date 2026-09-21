# frozen_string_literal: true

RSpec.describe ActionQuery::SearchQuery, "sorting" do
  subject(:query) { query_class.new }

  let(:query_class) { Class.new(described_class) { query_from User } }
  let(:sort_option_class) { Struct.new(:strategy, :direction, keyword_init: true) }

  describe "#apply_sorting" do
    it "returns itself when no option is supplied" do
      expect(query.apply_sorting(nil)).to equal(query)
    end

    it "orders by the strategy and direction by default" do
      older = User.create!(name: "Grace", age: 85)
      younger = User.create!(name: "Ada", age: 37)
      option = sort_option_class.new(strategy: :age, direction: :desc)

      expect(query.apply_sorting(option).to_a).to eq([older, younger])
    end

    it "accepts string strategies and directions" do
      ada = User.create!(name: "Ada")
      grace = User.create!(name: "Grace")
      option = sort_option_class.new(strategy: "name", direction: "asc")

      expect(query.apply_sorting(option).to_a).to eq([ada, grace])
    end

    it "uses a configured sort in the query context" do
      query_class.sort_by :seniority, ->(direction) { order(age: direction) }
      younger = User.create!(name: "Ada", age: 37)
      older = User.create!(name: "Grace", age: 85)
      option = sort_option_class.new(strategy: :seniority, direction: :asc)

      expect(query.apply_sorting(option).to_a).to eq([younger, older])
    end

    it "lets Active Record reject invalid directions" do
      option = sort_option_class.new(strategy: :name, direction: "sideways")

      expect { query.apply_sorting(option) }.to raise_error(ArgumentError, /direction.*invalid/i)
    end
  end

  describe ".sort_by" do
    it "normalizes string option names" do
      processor = ->(direction) { order(name: direction) }

      query_class.sort_by "alphabetical", processor

      expect(query_class.sort_options[:alphabetical]).to equal(processor)
    end

    it "inherits parent sorts without leaking child sorts" do
      query_class.sort_by :alphabetical, ->(direction) { order(name: direction) }
      child = Class.new(query_class)
      sibling = Class.new(query_class)
      child.sort_by :seniority, ->(direction) { order(age: direction) }

      expect(child.sort_options).to include(:alphabetical, :seniority)
      expect(query_class.sort_options).to include(:alphabetical)
      expect(query_class.sort_options).not_to have_key(:seniority)
      expect(sibling.sort_options).not_to have_key(:seniority)
    end
  end
end
