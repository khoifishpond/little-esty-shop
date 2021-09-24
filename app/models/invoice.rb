class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  

  enum status: {
    'in progress': 0,
    cancelled: 1,
    completed: 2,
  }

  def created_at_formatted
    created_at.strftime("%A, %B %d, %Y")
  end

  def created_at_short_format
    created_at.strftime("%x")
  end

  def customer_by_id
    Customer.find(customer_id)
  end

  def item_unit_price(item_id)
    invoice_items.where(item_id: item_id).first.unit_price
  end

  def item_status(item_id)
    invoice_items.where(item_id: item_id).first.status
  end

  def total_revenue
    invoice_items.where(invoice_id: id).sum('quantity * unit_price')
  end

  def discount
    # poop = invoice_items
    #   .joins(item: {merchant: :bulk_discounts})
    #   .select('invoice_items.*, bulk_discounts.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS invoice_discount')
    #   .group('invoices.id, merchants.id')
    #   .where(invoice_id: id)

    # poop = invoice_items
    #   .joins(item: {merchant: :bulk_discounts})
    #   .sum('(invoice_items.quantity * (1 - discount) * invoice_items.unit_price)')
  
    # quantity = poop.first.quantity

    # discount = poop.first
    #   .item
    #   .merchant
    #   .bulk_discounts
    #   .where('bulk_discounts.quantity_threshold <= ?', quantity)

    

    require 'pry'; binding.pry
  end

  def discounted_revenue
    total_revenue - discount
  end
end