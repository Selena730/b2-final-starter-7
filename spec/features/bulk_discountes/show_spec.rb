require 'rails_helper'

RSpec.describe 'Bulk Discount Show page', type: :feature do
    it "shows the bulk discounts quantity threshold and percentage discount" do
        merchant = Merchant.create!(name: "Hair Care")
        bulk_discount = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10)

        visit merchant_bulk_discount_path(merchant, bulk_discount)

        expect(page).to have_content("Discount: 10%")
        expect(page).to have_content("Quantity Threshold: 10")
    end
end