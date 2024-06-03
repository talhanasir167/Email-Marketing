# frozen_string_literal: true

class FollowupEmailWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'followups'

  def perform(params)
    UserMailer.send_followup_email(params).deliver_now
  end
end
