require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'instance methods' do
    before(:each) do
      @merch1 = create(:merchant)
      @discount10 = @merch1.bulk_discounts.create(percentage_discount: 10, quantity_threshold: 10)
      @item1 = create(:item, merchant: @merch1)
      @cust1 = create(:customer)
      @invoice1 = create(:invoice, customer: @cust1)
      @ii = InvoiceItem.create(item: @item1, invoice: @invoice1, status: 1, quantity: 15, unit_price: 1000)
    end

    it '#discount' do
      expect(@ii.discount).to eq(10)
    end
  end
end
