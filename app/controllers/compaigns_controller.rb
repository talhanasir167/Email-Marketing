require 'csv'
class CompaignsController < ApplicationController
  before_action :set_compaign, only: %i[show edit update destroy]
  before_action :set_business, only: %i[new create]
  before_action :set_followup, :previous_followups_sent?, only: %i[followup]

  def show; end

  def new
    @compaign = @business.compaigns.new
    @compaign.followups.build
  end

  def create
    @compaign = @business.compaigns.new(compaign_params)

    if validate_csv_headers(params[:compaign][:csv_file]) && @compaign.save
      CompaignsProcessingService.new({ compaign: @compaign, csv_file: params[:compaign][:csv_file] }).call!
      redirect_to @compaign, notice: 'compaign was successfully created and is processed'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @compaign.update(compaign_params)
      redirect_to @compaign, notice: 'compaign was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @compaign.destroy
    redirect_to @compaign.business, notice: 'compaign was successfully destroyed.'
  end

  def followup
    if FollowupService.new(@followup).call!
      redirect_to @followup.compaign, notice: 'Follow-up emails were successfully sent'
    else
      redirect_to @followup.compaign, alert: 'Problem sending follow-up emails'
    end
  end

  private

  def set_compaign
    @compaign = Compaign.find(params[:id])
  end

  def set_followup
    @followup = Followup.find(params[:id])
  end

  def compaign_params
    params.require(:compaign).permit(:business_email_id, :service_id, :title_id, :country_id, :scheduled_at,
                                     followups_attributes: %i[id _destroy sent_at content])
  end

  def set_business
    @business = Business.find(params[:business_id])
  end

  def previous_followups_sent?
    return unless @followup.compaign.followups.where('id < ?', @followup.id).exists?(sent: false)

    flash[:alert] = 'Cannot send followup until all previous followups are sent'
    redirect_to @followup.compaign
  end

  def validate_csv_headers(file)
    require_headers = %w[Name Email Subject Body]

    CSV.foreach(file, headers: true) do |row|
      missing_headers = require_headers - row.headers
      return true unless missing_headers.any?

      @compaign.errors.add(:base, "Missing headers: #{missing_headers.join(', ')}")
      return false
    end
  end
end
