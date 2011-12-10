class AssociationsController < ApplicationController
  before_filter :must_be_admin
  layout nil

  def create
    @association = Association.new(params[:association])
    if @association.save
      render :json => { :success => true, :association => @association }
    else
      render :json => { :success => false, :message => @association.errors }
    end
  end

  def index
    raise "No company id passed while creating a new certification" if params[:company_id].nil?
    @company = Company.find_by_id params[:company_id]
  end

  def new
    raise "No company id passed while creating a new certification" if params[:company_id].nil?

    @association = Association.new
    @association.company_id = params[:company_id]
  end

  def update
    @association = Association.find(params[:id])
    if @association.update_attributes(params[:association])
      render :json => {:success => true, :association => @association }
    else
      render :json => {:success => false, :message => @association.errors }
    end
  end

  def destroy
    @association = Association.find(params[:id])
    @association.destroy
    render :json => { :success => true }
  end
end
