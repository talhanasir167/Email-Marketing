class GeneratedEmail < ApplicationRecord
  validates :email, :subject, :message_id, presence: true
  validates :lead_id, uniqueness: { scope: [:business_id] }

  belongs_to :business
  belongs_to :lead

  scope :followup_emails, lambda { |business, leads|
                            where(business:, lead: leads).includes(:lead).where(leads: { active: true })
                          }
end
