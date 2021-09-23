class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayFacade.holidays
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.create(bulk_discount_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.destroy(params[:id])  
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  end
end