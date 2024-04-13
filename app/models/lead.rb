class Lead < ApplicationRecord
  validates :contacts_count, :scheduled_at, presence: true

  belongs_to :business
  belongs_to :business_email
  has_many :contacts, dependent: :destroy
  has_many :followups, dependent: :destroy

  accepts_nested_attributes_for :followups, reject_if: :all_blank, allow_destroy: true

  validate :max_followups_limit

  private

  def max_followups_limit
    return unless followups.size > 5

    errors.add(:followups, "can't exceed 5")
  end
end
