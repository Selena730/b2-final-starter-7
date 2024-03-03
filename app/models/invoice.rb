class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounts
    invoice_items.joins(item: { merchant: :bulk_discounts }) # Joining invoice_items with bulk_discounts through the items and merchants to access the data that we want
                 .where("invoice_items.quantity >= bulk_discounts.quantity_threshold") # making sure that invoice_items quantity meets the bulk_discounts.quantity_threshold
                 .select("invoice_items.id, MAX(bulk_discounts.percentage_discount) / 100.0 * (invoice_items.unit_price * invoice_items.quantity) AS discount_amount")
                 .group("invoice_items.id") # grouping
                 .sum(&:discount_amount) #  to get the total discount for the invoice.
   # selecting the maximum discount percentage, dividing by 100.0, and then multiplying by the product of unit_price and quantity for the invoice_tem.              
  end

  def total_discounted_revenue
    total_revenue - total_discounts
  end
end
