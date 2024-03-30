class Lead < ApplicationRecord
  validates :first_followup, :second_followup, :third_followup, :fourth_followup, :count, :followup_count, presence: true

  has_many :users, dependent: :destroy
  belongs_to :business
end
