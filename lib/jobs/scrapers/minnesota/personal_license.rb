require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      class PersonalLicense < AbstractDOLIScraper

        IDS = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction
                  CEStatus Name Address1 Address2 Phone Fax Other ]

        def self.perform(license_number)
          exit if license_number.nil?

          output = parse_page(:personal, license_number, IDS)

          File.open('tmp/personal_licenses.yml', 'a') do |f|
            file_output = output.dup
            file_output[:lic_type] = file_output[:lic_type].name
            file_output[:lic_status] = file_output[:lic_status].name
            file_output.stringify_keys!
            f.puts file_output.to_yaml
          end

          REDIS[:default].publish(:scraper_results, { personal_license: output }.to_json)

          return output
        end
      end
    end
  end
end