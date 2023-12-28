class User < ApplicationRecord
  validates :email, presence: true
  belongs_to :lead
end
