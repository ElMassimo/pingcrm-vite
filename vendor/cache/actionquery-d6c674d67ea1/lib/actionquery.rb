# frozen_string_literal: true

require "active_record"
require "active_support/core_ext/string/inflections"

# Relation-backed query objects for Active Record.
module ActionQuery
end

require_relative "actionquery/error"
require_relative "actionquery/version"
require_relative "actionquery/base"
require_relative "actionquery/search_query"
