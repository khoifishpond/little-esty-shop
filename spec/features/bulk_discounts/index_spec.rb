require 'rails_helper'

describe 'bulk discounts index' do
  before(:each) do
    @merch1 = create(:merchant)
    @item1 = create(:item, merchant: @merch1)
    @item2 = create(:item, merchant: @merch1)
    @item3 = create(:item, merchant: @merch1)
    @discount10 = @merch1.bulk_discounts.create(percentage_discount: 10, quantity_threshold: 10)
    @discount15 = @merch1.bulk_discounts.create(percentage_discount: 15, quantity_threshold: 15)
    @discount20 = @merch1.bulk_discounts.create(percentage_discount: 20, quantity_threshold: 20)
    
    visit merchant_bulk_discounts_path(@merch1)
  end
  
  it 'has a link to view all discounts' do
    within("#discount-#{@discount10.id}") do
      expect(page).to have_content(@discount10.percentage_discount)
      expect(page).to have_content(@discount10.quantity_threshold)
      
      click_link "#{@discount10.percentage_discount}"
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount10))
    visit merchant_bulk_discounts_path(@merch1)

    within("#discount-#{@discount15.id}") do
      expect(page).to have_content(@discount15.percentage_discount)
      expect(page).to have_content(@discount15.quantity_threshold)
      
      click_link "#{@discount15.percentage_discount}"
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount15))
    visit merchant_bulk_discounts_path(@merch1)

    within("#discount-#{@discount20.id}") do
      expect(page).to have_content(@discount20.percentage_discount)
      expect(page).to have_content(@discount20.quantity_threshold)
      
      click_link "#{@discount20.percentage_discount}"
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount20))
  end
end