# frozen_string_literal: true

RSpec.describe ActionQuery do
  it "has a version number" do
    expect(ActionQuery::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end

  it "defines a library error base class" do
    expect(ActionQuery::Error).to be < StandardError
  end
end
