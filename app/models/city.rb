class City < ApplicationRecord
  validates :namae, presence: true

  belongs_to :country
end
