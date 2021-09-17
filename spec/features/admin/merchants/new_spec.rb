RSpec.describe 'Admin Merchant Index page' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant, status: 0)
    visit new_merchant_path
  end

  it 'has a form to create a new merchant' do
    expect(page).to have_content("New Merchant")
    expect(page).to have_field("Name")
    expect(page).to have_button("Create Merchant")
  end

  it 'creates a new merchant' do
    fill_in "Name", with: "Antonio Gibson Incorporated"
    click_button "Create Merchant"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Antonio Gibson Incorporated")
  end
end
