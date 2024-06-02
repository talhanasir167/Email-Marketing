class Lead < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  belongs_to :country
  belongs_to :title
  belongs_to :platform
end
