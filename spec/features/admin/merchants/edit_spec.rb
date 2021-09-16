require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch = create(:merchant, name: 'Discraft')
    visit edit_admin_merchant_path(@merch)
  end

  it 'has a form to update merchant' do
    expect(page).to have_content('Discraft')

    fill_in('Name', with: 'Innova')
    click_button('Submit')

    expect(current_path).to eq(admin_merchant_path(@merch))
    expect(page).to have_content("Merchant has been updated successfully")
    expect(page).to_not have_content('Discraft')
    expect(page).to have_content('Innova')
  end
end
