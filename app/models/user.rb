class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable

  validates :name, :email, presence: true

  has_many :businesses
end
