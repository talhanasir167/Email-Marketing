class Platform < ApplicationRecord
  validates :name, presence: true

  has_many :compaigns

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at]
  end
end
