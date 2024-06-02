class Business < ApplicationRecord
  validates :name, :tag_line, :email, :encrypted_password, presence: true

  belongs_to :user
  has_many :business_emails, dependent: :destroy
  has_many :services, dependent: :destroy

  accepts_nested_attributes_for :business_emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :services, reject_if: :all_blank, allow_destroy: true

  def compaigns
    Compaign.where(service_id: services.ids)
  end
end
