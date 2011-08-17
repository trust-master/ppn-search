require 'fileutils'

class CompaniesController < ApplicationController
  before_filter :find_company, :only => [:show, :edit, :update, :destroy]
  before_filter :must_be_admin

  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.xml  { render :xml => @company }
    end
  end


    def edit
        @company_categories = CompanyCategory.all
        @company_subcategories = CompanySubcategory.all
        @service_areas = ServiceArea.all
        
        @service_areas.each do |service_area|
            coverage = @company.service_area_coverages.find_all{|item| item.service_area_id == service_area.id}.first()
            needs_saving = false
            if coverage.nil?
                coverage = ServiceAreaCoverage.new()
                coverage.company_id = @company.id
                coverage.service_area_id = service_area.id
                coverage.coverage_type = 0
                @company.service_area_coverages << coverage
                needs_saving = true
            end
            @company.save if needs_saving
        end
    end

    def create
        @company = Company.new(params[:company])
        if @company.save
            render :json => { :success => true, :company_id => @company.id}
        else
            render :json => { :success => false, :message => @company.errors}
        end
    end

    # PUT /companies/1
    # PUT /companies/1.xml
    def update
        if !params[:service_area_coverages].nil? and params[:service_area_coverages].count > 0
            @company.service_area_coverages.delete_all
            params[:service_area_coverages].each do |entry|
                service_area_coverage = ServiceAreaCoverage.new(entry)
                @company.service_area_coverages << service_area_coverage
            end
        end
        if params[:certificate_of_insurance]
            old_path = "assets/data/#{@company.id}/#{@company.certificate_of_insurance_filename}"
            File.delete old_path if File.exists? old_path
            @company.certificate_of_insurance_filename = params[:certificate_of_insurance].original_filename
            path = "assets/data/#{@company.id}/"
            FileUtils.mkdir_p path unless File.exists?(path) && File.directory?(path)
            File.open("#{path}/#{@company.certificate_of_insurance_filename}", "wb"){|f| f.write(params[:certificate_of_insurance].read) }
        end
        if @company.update_attributes(params[:company])
            render :json => {:success => true, :certificate_of_insurance_filename => @company.certificate_of_insurance_filename }
        else
            render :json => {:success => false, :message => @company.errors}
        end
    end

    # DELETE /companies/1
    # DELETE /companies/1.xml
    def destroy
        @company.destroy

        respond_to do |wants|
          wants.html { redirect_to(companies_url) }
          wants.xml  { head :ok }
        end
    end

  private
    def find_company
      @company = Company.find(params[:id])
    end

end
