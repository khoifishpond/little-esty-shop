require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
  before :each do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust2)
    InvoiceItem.create(item: @item1, invoice: @invoice1)
    InvoiceItem.create(item: @item2, invoice: @invoice2)
    InvoiceItem.create(item: @item3, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice2)
    InvoiceItem.create(item: @item1, invoice: @invoice3)
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'success')
    create(:transaction, invoice: @invoice1, result: 'failed')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice2, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')
    create(:transaction, invoice: @invoice3, result: 'success')

    visit '/admin/invoices'
  end

  it 'Shows all Invoice IDs in system' do
    within("#invoice-#{@invoice1.id}") do
      expect(page).to have_link("#{@invoice1.id}")
    end

    within("#invoice-#{@invoice2.id}") do
      expect(page).to have_link("#{@invoice2.id}")
    end

    within("#invoice-#{@invoice3.id}") do
      expect(page).to have_link("#{@invoice3.id}")
    end
  end
end
