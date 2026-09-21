# frozen_string_literal: true

# An Active Record relation that can be extended with ordinary instance methods.
class ActionQuery::Base < ActiveRecord::Relation
  class << self
    # Sets the model or relation used when constructing this query.
    def query_from(source)
      @query_source = source
    end

    # Wraps an existing relation in this query class.
    def wrap(relation)
      new.merge(relation)
    end

    # Returns the Active Record model queried by this class.
    def model_class
      source = query_source
      source.is_a?(ActiveRecord::Relation) ? source.model : source
    end

    private

    def query_source
      return @query_source if instance_variable_defined?(:@query_source)

      @query_source = inherited_query_source || infer_model_class
    rescue NameError
      message = "A model could not be inferred for #{name || self}. Follow the naming convention " \
                "or specify one with `query_from`."
      raise NotImplementedError, message
    end

    def inherited_query_source
      return unless superclass.respond_to?(:query_source, true)

      superclass.send(:query_source)
    end

    def infer_model_class
      model_name = name.sub(/(Search)?Query\z/, "").singularize
      model_name.safe_constantize || model_name.demodulize.constantize
    end
  end

  query_from false

  delegate :name, :model_class, to: :class
  delegate :attribute_types, :columns_hash, :logger, :sanitize_sql_like, :uncached, to: :model_class
  delegate :adapter_class, :connection, :connection_pool, :lease_connection, :primary_key, :with_connection,
           to: :model_class

  def initialize
    source = self.class.send(:query_source)
    raise NotImplementedError, abstract_query_message unless source

    model, options = initialization_attributes(source)
    super(model, **options)
  end

  # Applies an OR expression composed from the supplied Arel conditions.
  def any_of(*conditions)
    return self if conditions.empty?

    first_condition, *remaining_conditions = conditions
    where(remaining_conditions.reduce(first_condition, &:or))
  end

  def paginate(page_number:, page_size:)
    return self unless page_size

    offset((page_number - 1) * page_size).limit(page_size)
  end

  def scope_if(condition)
    condition ? yield(self) : self
  end

  def unsorted
    except(:order)
  end

  # With a column, returns its unique values. Otherwise retains Active Record behavior.
  # The boolean default intentionally matches ActiveRecord::Relation#distinct.
  # rubocop:disable-next Style/OptionalBooleanParameter
  def distinct(column = true)
    return super unless column.is_a?(Symbol)

    super().select(column).pluck(column).flatten.uniq
  end

  def union(relation)
    unscope(:where).from(arel.union(relation.arel).as(table.name))
  end

  protected

  def column_type(column_name)
    name = column_name.to_s
    return :enum if model_class.respond_to?(:defined_enums) && model_class.defined_enums.key?(name)

    attribute_types[name]&.type
  end

  # rubocop:disable-next Naming/PredicatePrefix
  def has_column?(column_name)
    columns_hash.key?(column_name.to_s)
  end

  private

  def respond_to_missing?(method_name, include_private = false)
    model_class.respond_to?(method_name, include_private) || super
  end

  def method_missing(method_name, ...)
    return super unless model_class.respond_to?(method_name)

    scoping { model_class.public_send(method_name, ...) }
  end

  def abstract_query_message
    "#{self.class.name || self.class} is an abstract query, create a subclass instead."
  end

  def initialization_attributes(source)
    return [source, {}] unless source.is_a?(ActiveRecord::Relation)

    options = {
      table: source.table,
      predicate_builder: source.predicate_builder,
      values: source.values.dup
    }
    [source.model, options]
  end
end
