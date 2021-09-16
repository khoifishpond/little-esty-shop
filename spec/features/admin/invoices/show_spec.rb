require 'rails_helper'

describe 'admin invoices show page' do
  before(:each) do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1)
    InvoiceItem.create(item: @item1, invoice: @invoice1)
    # create(:transaction, invoice: @invoice1, result: 'success')
    # create(:transaction, invoice: @invoice1, result: 'success')
    # create(:transaction, invoice: @invoice1, result: 'failed')

    visit "/admin/invoices/#{@invoice1.id}"
  end
  
  it 'displays information related to invoice' do
    save_and_open_page
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@cust1.first_name)
    expect(page).to have_content(@cust1.last_name)
  end
end