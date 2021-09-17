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

  it 'has a button to enable/disable merchant' do
    within("#merchant-#{@merch1.id}") do
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
      click_button("Enable")
      expect(current_path).to eq(admin_merchants_path)

      @merch1.reload

      expect(page).to have_content("enabled")
      expect(@merch1.status).to eq("enabled")

      click_button("Disable")
      @merch1.reload

      expect(page).to have_content("disabled")
      expect(@merch1.status).to eq("disabled")
    end
  end

  it 'has an enabled only section' do
    within("#enabled") do
      within("#item-#{@item2.id}") do
        expect(@item2.enable).to eq("enabled")
        expect(page).to have_content("#{@item2.name}")
        click_on "Disable"
      end
    end
  end

  it 'has an disabled only section' do
    within("#disabled") do
      within("#item-#{@item3.id}") do
        expect(@item3.enable).to eq("disabled")
        expect(page).to have_content("#{@item3.name}")
      end
    end
  end
end
