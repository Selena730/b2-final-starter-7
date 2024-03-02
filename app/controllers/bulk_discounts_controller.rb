class BulkDiscountsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id]) 
      @bulk_discounts = @merchant.bulk_discounts
    end

    def show
        # @merchant = Merchant.find(params[:merchant_id])
        # @bulk_discount = @merchant.bulk_discounts.find(params[:id])
    end

    def new
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = BulkDiscount.new
    end

    def create 
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
        if @bulk_discount.save
            redirect_to merchant_bulk_discounts_path(@merchant)
        else 
            render :new
        end
    end


    def destroy
        @merchant = Merchant.find(params[:merchant_id])
        @bulk_discount = @merchant.bulk_discounts.find(params[:id])
        @bulk_discount.destroy
        redirect_to merchant_bulk_discounts_path(@merchant)
    end

    private

    def bulk_discount_params
        params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
    end
end