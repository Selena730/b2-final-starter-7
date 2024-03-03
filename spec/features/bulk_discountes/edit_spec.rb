require "rails_helper"

RSpec.describe "Edit Bulk Discount", type: :feature do
    it "tests for sad path" do
        merchant = Merchant.create!(name: "Hair Care")
        bulk_discount = merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10)

        visit edit_merchant_bulk_discount_path(merchant, bulk_discount)
    
        fill_in "Percentage Discount", with: "" 
        fill_in "Quantity Threshold", with: "" 

        expect(page).to have_content("Edit Bulk Discount") 
        click_button "Update Discount"

        expect(current_path).to eq(merchant_bulk_discount_path(merchant, bulk_discount))
    end
end