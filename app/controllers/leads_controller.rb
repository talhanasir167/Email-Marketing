class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]
  before_action :set_businesses, only: %i[new edit]

  # GET /leads or /leads.json
  def index
    @leads = Lead.all
  end

  # GET /leads/1 or /leads/1.json
  def show; end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit; end

  # POST /leads or /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        LeadsProcessingService.new({ lead_id: @lead, csv_file: params[:lead][:csv_file] }).call!
        format.html { redirect_to lead_url(@lead), notice: 'Lead was successfully created and being processed' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to lead_url(@lead), notice: 'Lead was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1 or /leads/1.json
  def destroy
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lead_params
    params.require(:lead).permit(:business_id, :first_followup, :second_followup, :third_followup, :fourth_followup)
  end

  def set_businesses
    @businesses = Business.all.pluck(:name, :id)
  end
end
