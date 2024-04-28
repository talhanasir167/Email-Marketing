class Service < ApplicationRecord
  validates :name, presence: true

  belongs_to :business
  has_many :compaigns
end
