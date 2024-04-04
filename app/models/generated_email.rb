class GeneratedEmail < ApplicationRecord
  validates :email, :subject, :message_id, presence: true
  validates :contact_id, uniqueness: { scope: [:business_id] }

  belongs_to :business
  belongs_to :contact

  scope :followup_emails, lambda { |business, contacts|
                            where(business:, contact: contacts).includes(:contact).where(contacts: { active: true })
                          }
end
