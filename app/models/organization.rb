class Organization < ApplicationRecord
  belongs_to :account
  has_many :contacts, dependent: :destroy

  validates :name, presence: true

  include SoftDelete
end
