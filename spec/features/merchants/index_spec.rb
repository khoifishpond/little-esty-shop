require 'rails_helper'

RSpec.describe 'merchant index' do
  it 'shows merchant ids' do
    merch1 = create(:merchant)
    merch2 = create(:merchant)
    visit merchants_path
    
    expect(page).to have_content(merch1.name)
    expect(page).to have_content(merch2.name)
  end
end
