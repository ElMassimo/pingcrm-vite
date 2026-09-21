# frozen_string_literal: true

class User < ActiveRecord::Base
  enum :status, { invited: 0, active_member: 1, suspended: 2 }

  scope :active, -> { where(active: true) }
  scope :named, ->(name) { where(name:) }
  scope :with_minimum_age, ->(age:) { where(age: age..) }

  def self.transform_scope
    yield all
  end
end

# rubocop:disable-next Style/ClassAndModuleChildren
module Admin
  class User < ActiveRecord::Base
    self.table_name = "admin_users"
  end
end

class ExternalRecord < ActiveRecord::Base
  self.primary_key = "code"
end
