class LeadsController < ApplicationController
  before_action :set_lead, only: %i[edit update]

  def edit; end

  def update
    if @lead.update(lead_params)
      redirect_to @lead.compaign, notice: 'lead was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:name, :active)
  end
end
