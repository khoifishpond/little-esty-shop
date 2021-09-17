require 'rails_helper'

RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant, status: 0)
    visit admin_merchants_path
  end

  it 'shows the name of each merchant' do
    expect(page).to have_content(@merch1.name)
    expect(page).to have_content(@merch2.name)
  end

  it 'has links to merchants admin show page' do
    click_link("#{@merch1.name}")

    expect(current_path).to eq("/admin/merchants/#{@merch1.id}")

    visit "/admin/merchants"
    click_link("#{@merch2.name}")

    expect(current_path).to eq("/admin/merchants/#{@merch2.id}")
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

end
