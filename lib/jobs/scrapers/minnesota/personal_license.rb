require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module PersonalLicense
        extend AbstractScraper
        extend AbstractDOLIScraper

        IDS = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction
                  CEStatus Name Address1 Address2 Phone Fax Other ]

        class << self

          def perform(license_number)
            output = parse_page(:personal, license_number, IDS)

            REDIS[:default].publish 'status', output.to_json

            return output
          end

        end
      end
    end
  end
end