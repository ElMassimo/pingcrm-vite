# frozen_string_literal: true

class ActionController::Parameters
  # Return a symbol-keyed hash suitable for forwarding as keyword arguments.
  def to_keywords
    to_h.symbolize_keys
  end
end
