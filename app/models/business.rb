class Business < ApplicationRecord
  validates :name, :description, presence: true

  has_many :leads, dependent: :destroy
  has_many :generated_emails, dependent: :destroy
end
