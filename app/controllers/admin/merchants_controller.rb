class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:name])

    if merchant.save
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = "Merchant has been updated successfully"
    end
  end
end
