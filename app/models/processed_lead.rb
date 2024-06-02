class ProcessedLead < ApplicationRecord
  validates :message_id, :email_subject, presence: true
  validates :active, inclusion: { in: [true, false] }

  belongs_to :lead
  belongs_to :compaign

  after_create :update_compaign

  private

  def update_compaign
    compaign.increment!(:leads_count)
  end
end
