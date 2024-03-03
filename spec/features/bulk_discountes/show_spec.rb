require 'rails_helper'

RSpec.describe 'Bulk Discount Show page', type: :feature do
    before(:each) do 
        @merchant = Merchant.create!(name: "Hair Care")
        @bulk_discount = @merchant.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 10)

        visit merchant_bulk_discount_path(@merchant, @bulk_discount)
    end
    it "shows the bulk discounts quantity threshold and percentage discount" do
       
        expect(page).to have_content("Discount: 10%")
        expect(page).to have_content("Quantity Threshold: 10")
    end

    describe 'Edit Bulk Discount' do
        it "updates tbulk discount and shows the updated attributes" do

            click_link "Edit"

            fill_in "Percentage Discount", with: "10"
            fill_in "Quantity Threshold", with: "10"
            click_button "Update Discount"

            expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount))
            expect(page).to have_content("Discount: 10%")
            expect(page).to have_content("Quantity Threshold: 10")
        end
    end
end