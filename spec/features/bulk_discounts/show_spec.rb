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
end