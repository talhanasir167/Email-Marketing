require 'csv'
class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]
  before_action :set_business, only: %i[new create]
  before_action :set_followup, :previous_followups_sent?, only: %i[followup]

  def show; end

  def new
    @lead = @business.leads.new
    @lead.followups.build
  end

  def create
    @lead = @business.leads.new(lead_params)

    if validate_csv_headers(params[:lead][:csv_file]) && @lead.save
      LeadsProcessingService.new({ lead: @lead, csv_file: params[:lead][:csv_file] }).call!
      redirect_to @lead, notice: 'Lead was successfully created and is processed'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lead.update(lead_params)
      redirect_to @lead, notice: 'Lead was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead.destroy
    redirect_to @lead.business, notice: 'Lead was successfully destroyed.'
  end

  def followup
    if FollowupService.new(@followup).call!
      redirect_to @followup.lead, notice: 'Follow-up emails were successfully sent'
    else
      redirect_to @followup.lead, alert: 'Problem sending follow-up emails'
    end
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def set_followup
    @followup = Followup.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:business_email_id, :service_id, :title_id, :country_id, :scheduled_at,
                                 followups_attributes: %i[id _destroy sent_at content])
  end

  def set_business
    @business = Business.find(params[:business_id])
  end

  def previous_followups_sent?
    return unless @followup.lead.followups.where('id < ?', @followup.id).exists?(sent: false)

    flash[:alert] = 'Cannot send followup until all previous followups are sent'
    redirect_to @followup.lead
  end

  def validate_csv_headers(file)
    require_headers = %w[Name Email Subject Body]

    CSV.foreach(file, headers: true) do |row|
      missing_headers = require_headers - row.headers
      return true unless missing_headers.any?

      @lead.errors.add(:base, "Missing headers: #{missing_headers.join(', ')}")
      return false
    end
  end
end
