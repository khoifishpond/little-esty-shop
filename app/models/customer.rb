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
    a = Customer.joins(invoices: :invoice_items)
              .select("invoices.id as invoice_id")
              .where.not("invoice_items.status = ?", 2)
  end
end
