class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def applied_discount
    applicable_discounts = item.merchant.bulk_discounts.where('quantity_threshold <= ?', quantity) # get to  all bulk_discounts associated with the merchant of the item
    # only include the ones where the quantity_threshold is less than or equal to the invoice item's quantity
    applicable_discounts.order(percentage_discount: :desc).first # Orders the remaining discounts by percentage_discount the highest discount comes first
  end
end
