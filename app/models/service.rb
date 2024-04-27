class Service < ApplicationRecord
  validates :name, presence: true

  belongs_to :business
end
