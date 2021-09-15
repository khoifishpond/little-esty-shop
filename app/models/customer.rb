class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  def self.top_five
    Customer.joins(invoices: :transactions)
            .select('customers.*, COUNT(transactions.result) as successful')
            .group('customers.id')
            .merge(Transaction.purchase)
            .order(successful: :desc, first_name: :asc, last_name: :asc)
            .limit(5)
  end

  def self.incomplete_invoices
    Customer.joins(invoices: :invoice_items)
            .select("invoices.id as invoice_id, invoices.created_at as created_at")
            .where.not("invoice_items.status = ?", 2)
            .order("invoices.created_at desc")
  end

  def created_at_formatted
    created_at.strftime("%A, %B %d, %Y")
  end
end
