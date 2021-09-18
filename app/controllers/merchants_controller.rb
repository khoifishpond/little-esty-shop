class MerchantsController < ApplicationController
  def show
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

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.create(merchant_create_params)

    if merchant.save
      redirect_to admin_merchants_path
    else
      redirect_to new_merchant_path
      flash[:notice] = "Merchant not created. Missing information"
    end
  end

private
  def merchant_params
    params.permit(:status)
  end

  def merchant_create_params
    params.require(:merchant).permit(:name)
  end
end
