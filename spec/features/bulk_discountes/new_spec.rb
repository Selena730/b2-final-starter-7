require "rails_helper"

RSpec.describe "Create New Bulk Discount", type: :feature do
    it "tests for sad path" do
        merchant = Merchant.create!(name: "Hair Care")
        visit new_merchant_bulk_discount_path(merchant)

        fill_in "Percentage discount", with: "" 
        fill_in "Quantity threshold", with: "" 

        expect(page).to have_content("Create New Bulk Discount") 
        click_button "Create Discount"

        expect(current_path).to eq(merchant_bulk_discounts_path(merchant))
    end
end