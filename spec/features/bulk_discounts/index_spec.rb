require 'rails_helper'

describe 'bulk discounts index' do
  before(:each) do
    @merch1 = create(:merchant)
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

  it 'has a section for upcoming holidays' do
    expect(page).to have_content("Columbus Day")
    expect(page).to have_content("2021-10-11")
    expect(page).to have_content("Veterans Day")
    expect(page).to have_content("2021-11-11")
    expect(page).to have_content("Thanksgiving Day")
    expect(page).to have_content("2021-11-25")
  end

  it 'has a link to create a new bulk discount' do
    click_link 'Create New Discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merch1))

    fill_in :bulk_discount_percentage_discount, with: 25
    fill_in :bulk_discount_quantity_threshold, with: 25
    click_on 'Create Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merch1))
    expect(page).to have_content('25%')
    expect(page).to have_content('25 items')
  end

  it 'has a link to delete a bulk discount' do
    within("#discount-#{@discount20.id}") do
      click_link 'Delete Discount'
    end
    save_and_open_page
    expect(page).to_not have_content("#{@discount20.percentage_discount}%")
    expect(page).to_not have_content("#{@discount20.quantity_threshold} items")
    expect(current_path).to have_content(merchant_bulk_discounts_path(@merch1))
  end
end