require 'rails_helper'

describe 'discount show page' do
  before(:each) do
    @merch1 = create(:merchant)
    @discount20 = @merch1.bulk_discounts.create(percentage_discount: 20, quantity_threshold: 20)
    
    visit merchant_bulk_discount_path(@merch1, @discount20)
  end

  it 'displays the discount attributes' do
    expect(page).to have_content(@discount20.percentage_discount)
    expect(page).to have_content(@discount20.quantity_threshold)
  end

  it 'has a link to edit the discount' do
    click_link 'Edit'

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merch1, @discount20))

    fill_in :bulk_discount_percentage_discount, with: 10
    fill_in :bulk_discount_quantity_threshold, with: 10
    click_on 'Edit Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merch1, @discount20))
    expect(page).to have_content('10%')
    expect(page).to have_content('10 items')
  end
end