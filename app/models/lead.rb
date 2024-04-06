class Lead < ApplicationRecord
  validates :count, presence: true

  belongs_to :business
  belongs_to :business_email
  has_many :contacts, dependent: :destroy
  has_many :followups, dependent: :destroy
end
