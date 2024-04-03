class BusinessEmail < ApplicationRecord
  validates :email, presence: true

  belongs_to :business
  has_many :leads
end
