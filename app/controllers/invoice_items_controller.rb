class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(status: params[:ii_status])
    # require 'pry'; binding.pry
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end
end
