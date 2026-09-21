# frozen_string_literal: true

# A query with conventions for filtering and sorting search results.
class ActionQuery::SearchQuery < ActionQuery::Base
  class << self
    def filter(field, processor)
      field = field.to_sym
      search_filters[field] = build_filter_processor(field, processor)
    end

    def sort_by(field, processor)
      sort_options[field.to_sym] = processor
    end

    def search_filters
      @search_filters ||= inherited_configuration(:search_filters)
    end

    def sort_options
      @sort_options ||= inherited_configuration(:sort_options)
    end

    private

    def build_filter_processor(field, processor)
      return processor unless processor.is_a?(Symbol)

      unless Arel::Attributes::Attribute.method_defined?(processor)
        raise ArgumentError, "Unknown operator for an Arel attribute: #{processor}"
      end

      return ->(value) { where(field => value) } if processor == :eq

      ->(value) { where(table[field].public_send(processor, value)) }
    end

    def inherited_configuration(name)
      return {} unless superclass.respond_to?(name)

      superclass.public_send(name).dup
    end
  end

  query_from false

  def search(**conditions)
    apply_search_filters(conditions)
  end

  def apply_search_filters(conditions)
    conditions.reduce(self) do |query, (field, value)|
      query.send(:apply_search_filter, field, value)
    end
  end

  def apply_sorting(sort_option)
    return self unless sort_option

    field = sort_option.strategy
    direction = sort_option.direction
    processor = self.class.sort_options[field.to_sym]

    processor ? instance_exec(direction, &processor) : order(field => direction)
  end

  def matches_any_of(fields, value)
    any_of(*fields.map { |field| matches(field, value) })
  end

  def with_ids(ids)
    where(primary_key => ids)
  end

  def all_attributes
    reselect(table[Arel.star])
  end

  protected

  def matches(field, value)
    attribute = field.respond_to?(:matches) ? field : table[field]
    attribute.matches("%#{sanitize_sql_like(value.to_s)}%", "\\")
  end

  def apply_search_filter(field, value)
    return self if field.to_s == "sort" || value.nil?

    processor = self.class.search_filters[field.to_sym]
    return instance_exec(value, &processor) if processor

    apply_automatic_filter(field, value)
  end

  private

  def apply_automatic_filter(field, value)
    case column_type(field)
    when :string, :text
      where(matches(field, value))
    when :datetime
      where(field => datetime_filter_value(value))
    when :boolean, :date, :decimal, :integer, :enum
      where(field => value)
    else
      raise_unsupported_filter(field)
    end
  end

  def datetime_filter_value(value)
    return value unless value.is_a?(Date) && !value.is_a?(DateTime)

    value.all_day
  end

  def raise_unsupported_filter(field)
    message = "Please implement `search` in #{self.class} to handle conditions on #{field.inspect}, " \
              "or define a handler using `filter :#{field}`."
    raise NotImplementedError, message
  end
end
