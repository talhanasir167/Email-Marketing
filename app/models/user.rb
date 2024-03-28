class User < ApplicationRecord
  validates :email, presence: true

  has_one :generated_email
  belongs_to :lead
end
