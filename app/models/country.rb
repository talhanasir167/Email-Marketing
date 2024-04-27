class Country < ApplicationRecord
  validates :namae, presence: true

  has_many :cities
end
