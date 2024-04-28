class Compaign < ApplicationRecord
  validates :leads_count, :scheduled_at, presence: true

  belongs_to :business
  belongs_to :business_email
  belongs_to :country
  belongs_to :title
  belongs_to :service
  belongs_to :platform
  has_many :leads, dependent: :destroy
  has_many :followups, dependent: :destroy

  accepts_nested_attributes_for :followups, reject_if: :all_blank, allow_destroy: true

  validate :max_followups_limit

  private

  def max_followups_limit
    return unless followups.size > 5

    errors.add(:followups, "can't exceed 5")
  end
end
