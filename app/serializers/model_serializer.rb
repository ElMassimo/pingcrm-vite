# frozen_string_literal: true

# Public: Helper to render only the id and name of the model.
class ModelSerializer < BaseSerializer
  attributes(id: { type: :number }, name: { type: :string })
end
