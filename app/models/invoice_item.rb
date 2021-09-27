class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  before_create :set_discount

  enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }

  def discounts
    item
      .merchant
      .bulk_discounts
      .where('bulk_discounts.quantity_threshold <= ?', quantity)
      .order('bulk_discounts.percentage_discount desc')
  end

  private

  def set_discount
    if !self.discounts.empty?
      self.discount = discounts.first.percentage_discount
    else
      self.discount = 0
    end
  end
end
