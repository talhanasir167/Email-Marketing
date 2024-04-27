class Service < ApplicationRecord
  validates :namae, :description, presence: true

  belongs_to :business
end
