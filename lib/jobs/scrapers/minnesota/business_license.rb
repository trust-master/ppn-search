require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module BusinessLicense
        extend AbstractScraper
        extend AbstractDOLIScraper

        IDS = %w[ CertificateMI LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt
                  EnforcementAction Name Address1 Address2 Phone Fax Other RelationName RespLicNo
                  RepStatus RepApplication RespExp RespEffect RespOrig ]

        class << self
          def perform(license_number)
            output = parse_page(:business, license_number, IDS)

            REDIS[:default].publish 'status', output.to_json

            return output
          end

        end
      end
    end
  end
end