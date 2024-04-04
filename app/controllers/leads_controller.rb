class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy followup]
  before_action :set_business, only: %i[new create]

  def show; end

  def new
    @lead = @business.leads.new
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
    if FollowupService.new({ lead: @lead, followup_count: params[:followup_count].to_i }).call!
      redirect_to @lead, notice: 'Follow-up emails were successfully sent'
    else
      redirect_to @lead, alert: 'Problem sending follow-up emails'
    end
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:business_email_id, :first_followup, :second_followup, :third_followup,
                                 :fourth_followup)
  end

  def set_business
    @business = Business.find(params[:business_id])
  end
end
