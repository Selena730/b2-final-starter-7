require 'rails_helper'

RSpec.describe 'Delete a Bulk Discount' do
    it "deletes a bulk discount and removes it from index page", type: :feature do
        merchant = Merchant.create!(name: "Hair Care")
        bulk_discount = merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)

        visit merchant_bulk_discounts_path(merchant)
        expect(page).to have_content("#{bulk_discount.percentage_discount}% off #{bulk_discount.quantity_threshold} items")


        expect(page).to have_content("20% off 20 items")

        click_on "Delete"

        expect(current_path).to eq(merchant_bulk_discounts_path(merchant))
        expect(page).not_to have_content("20% off 20 items")
    end
end