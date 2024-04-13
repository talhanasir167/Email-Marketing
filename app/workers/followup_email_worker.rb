# frozen_string_literal: true

class FollowupEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'followups'

  def perform(params)
    params = params.transform_keys(&:to_sym)
    params[:business] = Business.find(params[:business])

    UserMailer.send_followup_email(params).deliver_now
  end
end
