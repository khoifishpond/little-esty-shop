class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @merchants = Merchant.all
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    redirect_to admin_merchants_path
  end

private
  def merchant_params
    params.permit(:status)
  end
end
