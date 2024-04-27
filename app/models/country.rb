class Country < ApplicationRecord
  validates :name, presence: true

  has_many :leads
end
