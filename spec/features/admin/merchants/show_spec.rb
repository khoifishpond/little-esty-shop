require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    visit "/admin/merchants/#{@merch1.id}"
  end

  it 'has merchants name' do
    expect(page).to have_content(@merch1.name)
    expect(page).to_not have_content(@merch2.name)
  end

  it 'has link to edit merchant' do
    click_link("Update Merchant")

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}/edit")
  end
end
