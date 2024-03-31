class GeneratedEmail < ApplicationRecord
  validates :email, :subject, :message_id, presence: true
  validates :user_id, uniqueness: { scope: [:business_id] }

  belongs_to :business
  belongs_to :user

  scope :followup_emails, lambda { |business, users|
                            where(business:, user: users).includes(:user).where(users: { active: true })
                          }
end
