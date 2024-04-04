class Contact < ApplicationRecord
  validates :email, presence: true
  validates :active, inclusion: { in: [true, false] }

  has_many :generated_emails, dependent: :destroy
  belongs_to :lead
end
