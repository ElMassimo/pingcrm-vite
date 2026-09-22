class ApplicationQuery < ActionQuery::SearchQuery
  filter :trashed, ->(status) do
    case status
    when "with" then self
    when "only" then where.not(deleted_at: nil)
    else where(deleted_at: nil)
    end
  end

  def search(**conditions)
    conditions[:trashed] ||= ""
    super
  end
end
