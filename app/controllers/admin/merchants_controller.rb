class Admin::MerchantsController < AdminController
  before_action :merchant_by_id, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  def update
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "Merchant updated successfully"
    elsif
      redirect_to edit_admin_merchant_path(@merchant)
      flash[:danger] = "Name cannot be blank"
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def merchant_by_id
    @merchant = Merchant.find(params[:id])
  end
end
