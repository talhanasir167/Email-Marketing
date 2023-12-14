class Lead < ApplicationRecord
  validates :first_followup, :second_followup, :third_followup, :fourth_followup,  presence: true
  belongs_to :business
end
