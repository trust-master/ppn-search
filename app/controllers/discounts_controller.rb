class DiscountsController < ApplicationController
  load_and_authorize_resource

  def create
    @discount = Discount.new(params[:discount])
    @company = Company.find_by_id @discount.company_id

    if params[:image_file]
      @discount.image_filename = params[:image_file].original_filename
      path = "assets/data/#{@company.id}/discounts"
      FileUtils.mkdir_p path unless File.exists?(path) && File.directory?(path)
      File.open("#{path}/#{@discount.image_filename}", "wb") do |f|
        f.write(params[:image_file].read)
      end
    end

    if @discount.save
      render :json => { :success => true, :discount => @discount }
    else
      render :json => { :success => false, :message => @discount.errors }
    end
  end

  def destroy_image
    begin
      @discount = Discount.find params[:id]
      raise "Could not locate discount with id of #{params[:id]}" if @discount.nil?
      path = "assets/data/#{@discount.company_id}/discounts/#{@discount.image_filename}"
      image_does_not_exist = @discount.image_filename.nil? or !File.exists? path

      @discount.image_filename = nil
      @discount.save

      File.delete(path) unless image_does_not_exist

      render :json => { :success => true, :message => nil }
    rescue ex
      render :json => { :success => false, :message => ex.message }
    end
  end

  def edit
    raise "No discount id passed while editing a discount" if params[:id].nil?
    @discount = Discount.find params[:id]
    raise "Could not locate discount #{params[:id]} for editing" if @discount.nil?
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

  def show_image
    @discount = Discount.find params[:id]
    raise "Could not locate discount with id of #{params[:id]}" if @discount.nil?
    path = "assets/data/#{@discount.company_id}/discounts/#{@discount.image_filename}"
    image_does_not_exist = @discount.image_filename.nil? or !File.exists? path
    path = image_does_not_exist ? "public/images/fpo-default-discount.jpeg" : path
    data = File.open(path, "rb").read
    send_data(data, :filename => @discount.image_filename, :type => "image/jpeg")
  end

  def update
    @discount = Discount.find(params[:id])
    if params[:image_file]
      @discount.image_filename = params[:image_file].original_filename
      path = "assets/data/#{@discount.company_id}/discounts"
      FileUtils.mkdir_p path unless File.exists?(path) && File.directory?(path)
      File.open("#{path}/#{@discount.image_filename}", "wb") do |f|
        f.write(params[:image_file].read)
      end
    end

    if @discount.update_attributes(params[:discount])
      render :json => { :success => true, :discount => @discount }
    else
      render :json => { :success => false, :message => @discount.errors }
    end
  end

  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy
    render :json => { :success => true }
  end
end
