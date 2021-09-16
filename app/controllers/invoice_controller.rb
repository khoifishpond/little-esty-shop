class InvoiceController < ApplicationController
  def update
    require 'pry'; binding.pry
    invoice = Invoice.find(params[:invoice][:id])
    invoice.update(status: params[:invoice][:status])

    redirect_to admin_invoices_path(invoice)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status, :created_at, :updated_at)
  end
end