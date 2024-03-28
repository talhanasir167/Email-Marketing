class GeneratedEmail < ApplicationRecord
  validates :email, :subject, :message_id, presence: true

  belongs_to :user
end
