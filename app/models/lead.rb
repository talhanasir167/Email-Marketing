class Lead < ApplicationRecord
  validates :first_followup, :second_followup, :third_followup, :fourth_followup, :count, :followup_count,
            presence: true

  has_many :contacts, dependent: :destroy
  belongs_to :business
  belongs_to :business_email
end
