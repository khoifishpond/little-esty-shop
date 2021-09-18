class InvoiceItemsController < ApplicationController
  def update
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:invoice_item][:merchant_id])
    invoice = Invoice.find(params[:invoice_item][:invoice_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)

    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status, :id)
  end
end
