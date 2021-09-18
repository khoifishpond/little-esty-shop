require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch = create(:merchant, name: 'Discraft')
    visit edit_admin_merchant_path(@merch)
  end

  it 'has a form to update merchant' do
    expect(page).to have_content('Discraft')

    fill_in(:name, with: 'Innova')
    click_button('Update Merchant')

    expect(current_path).to eq(admin_merchant_path(@merch))
    expect(page).to have_content('Merchant updated successfully')
    expect(page).to_not have_content('Discraft')
    expect(page).to have_content('Innova')

    visit edit_admin_merchant_path(@merch)

    expect(page).to have_content('Innova')

    fill_in(:name, with: '         ')
    click_button('Update Merchant')

    expect(current_path).to eq(edit_admin_merchant_path(@merch))
    expect(page).to have_content('Name cannot be blank')
  end
end
