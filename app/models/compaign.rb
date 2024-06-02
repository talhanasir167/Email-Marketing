class Compaign < ApplicationRecord
  validates :email_subject, :email_body, :leads_count, :scheduled_at, presence: true

  belongs_to :business_email
  belongs_to :service
  has_many :followups, dependent: :destroy
  has_many :processed_leads, dependent: :destroy

  accepts_nested_attributes_for :followups, reject_if: :all_blank, allow_destroy: true

  validate :max_followups_limit

  def business
    service.business
  end

  private

  def max_followups_limit
    return unless followups.size > 5

    errors.add(:followups, "can't exceed 5")
  end
end
