class Business < ApplicationRecord
  validates :name, :description, presence: true
end
