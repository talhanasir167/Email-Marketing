class User < ApplicationRecord
  validates :email, presence: true

  has_many :generated_email, dependent: :destroy
  belongs_to :lead
end
