class GeneratedEmail < ApplicationRecord
  validates :email, :subject, :message_id, presence: true
  validates :lead_id, uniqueness: { scope: [:service_id] }

  belongs_to :service
  belongs_to :lead

  scope :followup_emails, lambda { |business, leads|
                            where(business:, lead: leads).includes(:lead).where(leads: { active: true })
                          }
end
