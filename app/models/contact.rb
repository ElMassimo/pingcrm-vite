class Contact < ApplicationRecord
  belongs_to :account
  belongs_to :organization, optional: true

  validates :first_name, :last_name, presence: true

  include SoftDelete

  def name
    "#{last_name}, #{first_name}"
  end
end
