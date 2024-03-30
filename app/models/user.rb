class User < ApplicationRecord
  validates :email, presence: true
  validates :active, inclusion: { in: [true, false] }

  has_many :generated_email, dependent: :destroy
  belongs_to :lead
end
