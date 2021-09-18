class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:invoice_item][:merchant_id])
    invoice = Invoice.find(params[:invoice_item][:invoice_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)

    if invoice_item.update(invoice_item_params)
      redirect_to merchant_invoice_path(merchant, invoice)
      flash[:notice] = "Invoice Item has updated sucessfully"
    end
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status, :id)
  end
end
