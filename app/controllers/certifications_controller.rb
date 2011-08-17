class CertificationsController < ApplicationController
    before_filter :must_be_admin
    layout nil
    def create
        @certification = Certification.new(params[:certification])
        @company = Company.find_by_id @certification.company_id

        if params[:certificate_file]
            @certification.certificate_filename = params[:certificate_file].original_filename
            path = "assets/data/#{@company.id}/certifications"
            FileUtils.mkdir_p path unless File.exists?(path) && File.directory?(path)
            File.open("#{path}/#{@certification.certificate_filename}", "wb"){|f| f.write(params[:certificate_file].read) }
        end

        if @certification.save
            render :json => { :success => true, :certification => @certification}
        else
            render :json => { :success => false, :message => @certification.errors}
        end
    end
    def new
        raise "No company id passed while creating a new certification" if params[:company_id].nil?

        @certification = Certification.new
        @certification.company_id = params[:company_id]
    end
    def destroy
        @certification = Certification.find(params[:id])
        @certification.destroy
        render :json => { :success => true }
    end
    def index
        raise "No company id passed while creating a new certification" if params[:company_id].nil?
        @company = Company.find_by_id params[:company_id]
    end
    def update
        @certification = Certification.find(params[:id])
        if @certification.update_attributes(params[:certification])
            render :json => {:success => true, :certification => @certification}
        else
            render :json => {:success => false, :message => @certification.errors}
        end
    end
end
