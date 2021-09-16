require 'rails_helper'

describe 'admin invoices show page' do
  before(:each) do
    @merch1 = create(:merchant)
    @cust1 = create(:customer)
    @item1 = create(:item, merchant: @merch1, unit_price: 3000)
    @item2 = create(:item, merchant: @merch1, unit_price: 6000)
    @item3 = create(:item, merchant: @merch1, unit_price: 4500)
    @invoice1 = create(:invoice, customer: @cust1, status: 0)
    @ii1 = InvoiceItem.create(item: @item1, invoice: @invoice1, unit_price: @item1.unit_price, quantity: 15, status: 0)
    @ii2 = InvoiceItem.create(item: @item2, invoice: @invoice1, unit_price: @item2.unit_price, quantity: 5, status: 1)
    @ii3 = InvoiceItem.create(item: @item3, invoice: @invoice1, unit_price: @item3.unit_price, quantity: 6, status: 2)

    visit "/admin/invoices/#{@invoice1.id}"
  end

  it 'displays information related to invoice' do
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@cust1.first_name)
    expect(page).to have_content(@cust1.last_name)
  end

  it 'displays all items on invoice' do
    within("#item-#{@ii1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@ii1.quantity)
      expect(page).to have_content(@ii1.status)
      expect(page).to have_content("$30.00")
    end

    within("#item-#{@ii2.id}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@ii2.quantity)
      expect(page).to have_content(@ii2.status)
      expect(page).to have_content("$60.00")
    end

    within("#item-#{@ii3.id}") do
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@ii3.quantity)
      expect(page).to have_content(@ii3.status)
      expect(page).to have_content("$45.00")
    end
  end

  it 'shows total revenue' do

    expect(page).to have_content("$1,020.00")
  end
end
