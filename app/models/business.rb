class Business < ApplicationRecord
  validates :name, :description, presence: true

  has_many :leads
end
