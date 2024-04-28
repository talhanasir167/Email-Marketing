class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  validates :name, :email, presence: true

  has_many :businesses, dependent: :destroy

  ROLES = {
    sales_manager: 0,
    admin: 1
  }.freeze

  enum role: ROLES

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name email created_at updated_at]
  end
end
