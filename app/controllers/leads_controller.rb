class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]
  before_action :set_business, only: %i[new create]
  before_action :set_followup, only: %i[followup]

  def show; end

  def new
    @lead = @business.leads.new
    @lead.followups.build
  end

  def create
    @lead = @business.leads.new(lead_params)

    if @lead.save
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
    params.require(:lead).permit(:business_email_id, followups_attributes: %i[id _destroy sent_at content])
  end

  def set_business
    @business = Business.find(params[:business_id])
  end
end
