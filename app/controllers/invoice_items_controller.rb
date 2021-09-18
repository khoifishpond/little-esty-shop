class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])

    if invoice_item.update(invoice_item_params)
      redirect_to merchant_invoice_path(merchant, invoice)
      flash[:notice] = "Invoice Item has updated sucessfully"
    end
  end

  private

  def invoice_item_params
    params.permit(:status)
  end
end
