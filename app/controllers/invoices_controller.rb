class InvoicesController < ApplicationController
  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)

    redirect_to admin_invoice_path(invoice)
    flash[:notice] = "Invoice has been successfully updated"
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status, :created_at, :updated_at)
  end
end
