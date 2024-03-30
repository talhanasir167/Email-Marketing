class BusinessesController < ApplicationController
  before_action :set_business, only: %i[show edit update destroy]

  def index
    @businesses = Business.all
  end

  def show; end

  def new
    @business = Business.new
  end

  def edit; end

  def create
    @business = Business.new(business_params)

    if @business.save
      redirect_to business_url(@business), notice: 'Business was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @business.update(business_params)
      redirect_to business_url(@business), notice: 'Business was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @business.destroy

    redirect_to businesses_url, notice: 'Business was successfully destroyed.'
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

  def business_params
    params.require(:business).permit(:name, :description)
  end
end
