class AffiliationsController < ApplicationController
  load_and_authorize_resource

  def create
    @affiliation = Affiliation.new(params[:affiliation])
    if @affiliation.save
      render :json => { :success => true, :affiliation => @affiliation }
    else
      render :json => { :success => false, :message => @affiliation.errors }
    end
  end

  def index
    raise "No company id passed while creating a new certification" if params[:company_id].nil?
    @company = Company.find_by_id params[:company_id]
  end

  def new
    raise "No company id passed while creating a new certification" if params[:company_id].nil?

    @company = Company.find(params[:company_id])
    @affiliation = @company.affiliations.build
  end

  def update
    @affiliation = Affiliation.find(params[:id])
    if @affiliation.update_attributes(params[:affiliation])
      render :json => { :success => true, :affiliation => @affiliation }
    else
      render :json => { :success => false, :message => @affiliation.errors }
    end
  end

  def destroy
    @affiliation = Affiliation.find(params[:id])
    @affiliation.destroy
    render :json => { :success => true }
  end

end
