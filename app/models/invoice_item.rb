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
      .first
  end

  private

  def set_discount
    if !self.discounts.nil?
      self.discount = discounts.percentage_discount
      self.discount_id = discounts.id
    else
      self.discount = 0
      self.discount_id = nil
    end
  end
end
