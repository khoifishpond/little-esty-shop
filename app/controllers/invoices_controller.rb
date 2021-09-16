class InvoicesController < ApplicationController
  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status])

    redirect_to admin_invoice_path(@invoice)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status, :created_at, :updated_at)
  end
end
