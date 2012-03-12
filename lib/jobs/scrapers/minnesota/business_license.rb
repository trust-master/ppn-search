require 'mechanize'
require 'json'

module Jobs::Scrapers
  module Minnesota
    class BusinessLicense < AbstractDOLIScraper

      IDS = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction Name
                Address1 Address2 Phone Fax Other RespLicNo ]

      def self.perform(company_id, license_number)
        if not AbstractDOLIScraper::LICENSE_NUMBER_PATTERN.match license_number
          raise ArgumentError, 'license_number is invalid!'
        end
        if not Company.where(id: company_id).any?
          raise ArgumentError, 'company_id is invalid!'
        end

        output = parse_page(:business, license_number, IDS)
        output[:real_name], output[:doing_business_as] = output[:name].split(/\s+DBA\s+/i)

        # Queue up the personal license that was referenced in this one
        if output[:resp_lic_no]
          Resque.enqueue(Minnesota::PersonalLicense, company_id, output[:resp_lic_no])
        end

        ::BusinessLicense.where(
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

          name:              output[:real_name],
          doing_business_as: output[:doing_business_as],

          responsible_person_license_number: output[:resp_lic_no],

          address:      output[:address],
          phone_number: output[:phone],

          raw_data: output.stringify_keys,

          fetched_at: Time.now
        }, without_protection: true)
      end

    end
  end
end
