# frozen_string_literal: true

RSpec.describe ActionQuery::SearchQuery, "automatic filters" do
  subject(:query) { query_class.new }

  let(:query_class) { Class.new(described_class) { query_from User } }

  describe "#search" do
    it "partially matches string columns without regard to case" do
      ada = User.create!(name: "Ada Lovelace")
      User.create!(name: "Grace Hopper")

      expect(query.search(name: "LOVEL")).to contain_exactly(ada)
    end

    it "partially matches text columns" do
      ada = User.create!(name: "Ada", biography: "The first programmer")
      User.create!(name: "Grace", biography: "Compiler pioneer")

      expect(query.search(biography: "program")).to contain_exactly(ada)
    end

    it "escapes LIKE wildcards in values" do
      literal = User.create!(name: "100%_real")
      User.create!(name: "100xxreal")

      expect(query.search(name: "100%_")).to contain_exactly(literal)
    end

    it "matches integer and decimal columns exactly" do
      matching = User.create!(name: "Ada", age: 37, balance: 12.50)
      User.create!(name: "Grace", age: 38, balance: 12.50)
      User.create!(name: "Linus", age: 37, balance: 15.00)

      expect(query.search(age: 37, balance: 12.50)).to contain_exactly(matching)
    end

    it "matches false boolean values rather than skipping them" do
      inactive = User.create!(name: "Ada", active: false)
      User.create!(name: "Grace", active: true)

      expect(query.search(active: false)).to contain_exactly(inactive)
    end

    it "matches date columns exactly" do
      birthday = Date.new(1815, 12, 10)
      ada = User.create!(name: "Ada", birthday:)
      User.create!(name: "Grace", birthday: Date.new(1906, 12, 9))

      expect(query.search(birthday:)).to contain_exactly(ada)
    end

    it "expands a Date into an all-day range for datetime columns" do
      day = Date.new(2026, 1, 15)
      morning = User.create!(name: "Morning", signed_in_at: day.to_time + 8.hours)
      evening = User.create!(name: "Evening", signed_in_at: day.to_time + 20.hours)
      User.create!(name: "Tomorrow", signed_in_at: day.next_day.to_time)

      expect(query.search(signed_in_at: day)).to contain_exactly(morning, evening)
    end

    it "matches a Time value exactly" do
      time = Time.utc(2026, 1, 15, 8, 30)
      matching = User.create!(name: "Ada", signed_in_at: time)
      User.create!(name: "Grace", signed_in_at: time + 1.minute)

      expect(query.search(signed_in_at: time)).to contain_exactly(matching)
    end

    it "matches a DateTime value exactly rather than expanding it to the entire day" do
      date_time = DateTime.new(2026, 1, 15, 8, 30)
      matching = User.create!(name: "Ada", signed_in_at: date_time)
      User.create!(name: "Grace", signed_in_at: date_time + Rational(1, 24))

      expect(query.search(signed_in_at: date_time)).to contain_exactly(matching)
    end

    it "matches enum values exactly" do
      invited = User.create!(name: "Ada", status: :invited)
      User.create!(name: "Grace", status: :active_member)

      expect(query.search(status: :invited)).to contain_exactly(invited)
      expect(query.search(status: "invite")).to be_empty
    end

    it "skips nil filters" do
      ada = User.create!(name: "Ada")
      grace = User.create!(name: "Grace")

      expect(query.search(name: nil)).to contain_exactly(ada, grace)
      expect(query.search(name: "Ada", age: nil)).to contain_exactly(ada)
    end

    it "ignores sort metadata with symbol or string keys" do
      ada = User.create!(name: "Ada")

      expect(query.search(sort: "name")).to contain_exactly(ada)
      expect(query.search(**{ "sort" => "name" })).to contain_exactly(ada)
    end

    it "returns the query subclass after composing filters" do
      expect(query.search(name: "Ada", active: true)).to be_a(query_class)
    end

    it "raises an actionable error for unsupported columns" do
      expect { query.search(metadata: { language: "Ruby" }) }
        .to raise_error(NotImplementedError, /define a handler using `filter :metadata`/)
    end

    it "raises an actionable error for unknown fields" do
      expect { query.search(missing: "value") }
        .to raise_error(NotImplementedError, /conditions on :missing/)
    end
  end

  describe "#matches_any_of" do
    it "partially matches any selected field" do
      query_class.class_eval do
        def general_search(value)
          matches_any_of(%i[name biography], value)
        end
      end
      by_name = User.create!(name: "Pioneer", biography: nil)
      by_biography = User.create!(name: "Ada", biography: "A computing pioneer")
      User.create!(name: "Grace", biography: "Compiler author")

      expect(query.general_search("pioneer")).to contain_exactly(by_name, by_biography)
    end
  end

  describe "#with_ids" do
    it "matches records by primary key" do
      ada = User.create!(name: "Ada")
      User.create!(name: "Grace")

      expect(query.with_ids([ada.id])).to contain_exactly(ada)
    end

    it "supports models with a custom primary key" do
      selected = ExternalRecord.create!(code: "selected", name: "Selected")
      ExternalRecord.create!(code: "other", name: "Other")
      external_query = Class.new(described_class) { query_from ExternalRecord }.new

      expect(external_query.with_ids(["selected"])).to contain_exactly(selected)
    end
  end

  describe "#all_attributes" do
    it "restores all table columns after a select" do
      User.create!(name: "Ada")
      selected_query = Class.new(described_class) { query_from User.select(:id) }.new

      expect(selected_query.all_attributes.first.attributes).to include("id", "name", "biography")
    end
  end
end
