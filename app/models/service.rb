class Service < ApplicationRecord
  validates :name, presence: true

  belongs_to :business
  has_many :compaigns, dependent: :destroy
  has_many :generated_emails, dependent: :destroy
end
