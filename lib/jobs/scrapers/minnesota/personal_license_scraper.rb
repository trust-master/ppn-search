require 'mechanize'
require 'json'

module Jobs::Scrapers
  module Minnesota
    class PersonalLicenseScraper < AbstractDOLIScraper
      include ::Sidekiq::Worker
      sidekiq_options queue: :scrapers

      include Jobs::Throttle
      self.throttle_limit = 15.minutes

      IDS = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction
                CEStatus Name Address1 Address2 Phone Fax Other ]

      def perform(company_id, license_number)
        if not AbstractDOLIScraper::LICENSE_NUMBER_PATTERN.match license_number
          raise ArgumentError, 'license_number is invalid!'
        end
        if not ::Company.where(id: company_id).any?
          raise ArgumentError, 'company_id is invalid!'
        end

        output = parse_page(:personal, license_number.dup, IDS)

        ::PersonalLicense.where(
          company_id:       company_id,
          number:           output[:lic_no],
          issuing_state_id: Minnesota.id

        ).order('updated_at desc').first_or_initialize.update_attributes!({

          type_id:   output[:type_id],
          status_id: output[:status_id],

          application_number: output[:app_no],

          expires_on:   parse_date(output[:exp_dt]),
          effective_on: parse_date(output[:eff_dt]),
          issued_on:    parse_date(output[:orig_dt]),
          printed_on:   parse_date(output[:print_dt]),

          enforcement_action: output[:enforcement_action],

          name: output[:name],

          continuing_education: output[:ce_status],

          address:      output[:address],
          phone_number: output[:phone],

          raw_data: output.stringify_keys,

          fetched_at: Time.now
        }, without_protection: true)

        if output[:lic_no] != license_number
          # the format of the license number that was supplied was wrong, but it's been corrected in
          # the new record, so we'll need to delete the old one
          ::PersonalLicense.where(
            company_id:       company_id,
            number:           license_number,
            issuing_state_id: Minnesota.id
          ).destroy_all
        end
      end

    end
  end
end
