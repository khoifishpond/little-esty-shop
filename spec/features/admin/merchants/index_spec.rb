require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    visit admin_merchants_path
  end

  it 'shows the name of each merchant' do
    expect(page).to have_content(@merch1.name)
    expect(page).to have_content(@merch2.name)
  end

  it 'has links to merchants admin show page' do
    click_link("#{@merch1.name}")

    expect(current_path).to eq(admin_merchant_path(@merch1))

    visit admin_merchants_path
    click_link("#{@merch2.name}")

    expect(current_path).to eq(admin_merchant_path(@merch2))
  end
end
