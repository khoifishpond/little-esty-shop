require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant, status: 0)
    @merch3 = create(:merchant, status: 0)
    @merch4 = create(:merchant, status: 0)
    @merch5 = create(:merchant)
    @merch6 = create(:merchant)
    @cust1 = create(:customer)
    @cust2 = create(:customer)
    @cust3 = create(:customer)
    @cust4 = create(:customer)
    @cust5 = create(:customer)
    @cust6 = create(:customer)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch2)
    @item3 = create(:item, merchant: @merch3)
    @item4 = create(:item, merchant: @merch4)
    @item5 = create(:item, merchant: @merch5)
    @item6 = create(:item, merchant: @merch6)
    @invoice1 = create(:invoice, customer: @cust1)
    @invoice2 = create(:invoice, customer: @cust2)
    @invoice3 = create(:invoice, customer: @cust3)
    @invoice4 = create(:invoice, customer: @cust4)
    @invoice5 = create(:invoice, customer: @cust5)
    @invoice6 = create(:invoice, customer: @cust6)
    InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, unit_price: 1000, quantity: 1)
    InvoiceItem.create(item: @item2, invoice: @invoice2, status: 1, unit_price: 2000, quantity: 1)
    InvoiceItem.create(item: @item3, invoice: @invoice3, status: 1, unit_price: 3000, quantity: 1)
    InvoiceItem.create(item: @item4, invoice: @invoice4, unit_price: 4000, quantity: 1)
    InvoiceItem.create(item: @item5, invoice: @invoice5, unit_price: 5000, quantity: 1)
    InvoiceItem.create(item: @item6, invoice: @invoice6, unit_price: 6000, quantity: 1)
    create(:transaction, invoice: @invoice1, result: 0)
    create(:transaction, invoice: @invoice2, result: 0)
    create(:transaction, invoice: @invoice3, result: 0)
    create(:transaction, invoice: @invoice4, result: 0)
    create(:transaction, invoice: @invoice5, result: 0)
    create(:transaction, invoice: @invoice6, result: 0)
    create(:transaction, invoice: @invoice1, result: 0)
    create(:transaction, invoice: @invoice2, result: 0)
    create(:transaction, invoice: @invoice3, result: 0)
    create(:transaction, invoice: @invoice4, result: 0)
    create(:transaction, invoice: @invoice5, result: 0)
    create(:transaction, invoice: @invoice6, result: 0)

    visit admin_merchants_path
  end

  it 'shows the name of each merchant' do
    expect(page).to have_content(@merch1.name)
    expect(page).to have_content(@merch2.name)
  end

  it 'has links to merchants admin show page' do
    within("#disabled") do
      click_link("#{@merch1.name}")
    end

    expect(current_path).to eq(admin_merchant_path(@merch1))

    visit admin_merchants_path

    within("#enabled") do
      click_link("#{@merch2.name}")
    end

    expect(current_path).to eq(admin_merchant_path(@merch2))
  end

  it 'has a button to enable/disable merchant' do
    within("#disabled") do
      within("#merchant-#{@merch1.id}") do
        expect(page).to have_button("Enable")
        click_button("Enable")
        expect(current_path).to eq(admin_merchants_path)
      end
    end

    @merch1.reload

    expect(@merch1.status).to eq("enabled")
  end

  it 'has an enabled only section' do
    within("#enabled") do
      within("#merchant-#{@merch2.id}") do
        expect(@merch2.status).to eq("enabled")
        expect(page).to_not have_content("#{@merch1.name}")
        expect(page).to have_content("#{@merch2.name}")
        click_button "Disable"
      end
    end
  end

  it 'has an disabled only section' do
    within("#disabled") do
      within("#merchant-#{@merch1.id}") do
        expect(@merch1.status).to eq("disabled")
        expect(page).to have_content("#{@merch1.name}")
        expect(page).to_not have_content("#{@merch2.name}")
        click_on "Enable"
      end
    end
  end

  it 'has a link to create a new merchant' do
    expect(page).to have_link("Create New Merchant")
  end

  it 'takes me to the admin merchants new page when I click the link' do
    click_link "Create New Merchant"
    expect(current_path).to eq(new_merchant_path)
  end

  it 'shows top 5 merchants by revenue' do
    expect(@merch6.name).to appear_before(@merch5.name)
    expect(@merch5.name).to appear_before(@merch4.name)
    expect(@merch4.name).to appear_before(@merch3.name)
    expect(@merch3.name).to appear_before(@merch2.name)
  end

  it 'shows the best day for each of the top 5 merchants' do
    within("#top_five-#{@merch6.id}") do
      expect(page).to have_content(@merch6.name)
      expect(page).to have_content(@invoice6.created_at_formatted)
    end

    within("#top_five-#{@merch5.id}") do
      expect(page).to have_content(@merch5.name)
      expect(page).to have_content(@invoice5.created_at_formatted)
    end

    within("#top_five-#{@merch4.id}") do
      expect(page).to have_content(@merch4.name)
      expect(page).to have_content(@invoice4.created_at_formatted)
    end

    within("#top_five-#{@merch3.id}") do
      expect(page).to have_content(@merch3.name)
      expect(page).to have_content(@invoice3.created_at_formatted)
    end

    within("#top_five-#{@merch2.id}") do
      expect(page).to have_content(@merch2.name)
      expect(page).to have_content(@invoice2.created_at_formatted)
    end
  end
end
