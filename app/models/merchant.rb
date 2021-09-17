class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  enum status: {
    enabled: 0,
    disabled: 1
  }

  def self.enabled
    where(status: 0)
  end

  def self.disabled
    where(status: 1)
  end

  def favorite_customers
    Customer.select("customers.*, COUNT(transactions.result) as purchases")
      .joins(invoices: [:items, :transactions])
      .where('items.merchant_id = ?', id)
      .merge(Transaction.purchase)
      .group(:id)
      .order(purchases: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    items.joins(:invoice_items)
        .where.not('invoice_items.status = ?', 2)
  end

  def top_five_items
    items.joins(invoice_items: {invoice: :transactions})
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where("transactions.result = ?", 0)
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end

  def all_invoices
    Invoice.select("invoices.*")
          .joins(:items)
          .where("items.merchant_id = ?", id)
          .group(:id)
          .order(:id)
  end
end
