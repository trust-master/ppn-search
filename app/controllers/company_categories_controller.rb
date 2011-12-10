class CompanyCategoriesController < ApplicationController
  load_and_authorize_resource

  def create
    @company_category = CompanyCategory.new(params[:company_category])
    if @company_category.save
      render :json => {
        :success => true,
        :company_category_id => @company_category.id,
        :company_category_name => @company_category.name
      }
    else
      render :json => { :success => false, :message => @company_category.errors }
    end
  end

end
