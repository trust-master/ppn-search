class DiscountsController < ApplicationController
    before_filter :must_be_admin

    layout nil
    
    def create
         @discount = Discount.new(params[:discount])
         @company = Company.find_by_id @discount.company_id

         if params[:image_file]
             @discount.image_filename = params[:image_file].original_filename
             path = "assets/data/#{@company.id}/discounts"
             FileUtils.mkdir_p path unless File.exists?(path) && File.directory?(path)
             File.open("#{path}/#{@discount.image_filename}", "wb"){|f| f.write(params[:image_file].read) }
         end
         
         if @discount.save
             render :json => { :success => true, :discount => @discount}
         else
             render :json => { :success => false, :message => @discount.errors}
         end
     end
     def index
         raise "No company id passed while creating a new certification" if params[:company_id].nil?
         @company = Company.find_by_id params[:company_id]
     end
     def new
         raise "No company id passed while creating a new certification" if params[:company_id].nil?

         @discount = Discount.new
         @discount.company_id = params[:company_id]
     end
     def update
         @discount = Discount.find(params[:id])
         if @discount.update_attributes(params[:discount])
             render :json => {:success => true, :discount => @discount}
         else
             render :json => {:success => false, :message => @discount.errors}
         end
     end
     def destroy
         @discount = Discount.find(params[:id])
         @discount.destroy
         render :json => { :success => true }
     end
end
