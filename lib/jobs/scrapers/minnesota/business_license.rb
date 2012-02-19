require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      class BusinessLicense < AbstractDOLIScraper

        IDS = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction Name
                  Address1 Address2 Phone Fax Other RespLicNo ]

        def self.perform(license_number)
          exit if license_number.nil?

          output = parse_page(:business, license_number, IDS)
          output[:name], output[:doing_business_as] = output[:name].split(/\s+DBA\s+/i)

          Resque.enqueue(Minnesota::PersonalLicense, output[:resp_lic_no]) if output[:resp_lic_no]

          File.open('tmp/business_licenses.yml', 'a') do |f|
            file_output = output.dup
            file_output[:lic_type] = file_output[:lic_type].name
            file_output[:lic_status] = file_output[:lic_status].name
            file_output.stringify_keys!
            f.puts file_output.to_yaml
          end

          REDIS[:default].publish(:scraper_results, { business_license: output }.to_json)

          return output
        end

      end
    end
  end
end