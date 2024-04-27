class Title < ApplicationRecord
  validates :namae, presence: true

  has_many :leads
end
