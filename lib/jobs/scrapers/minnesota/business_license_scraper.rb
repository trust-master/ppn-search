require 'mechanize'
require 'json'

module Jobs::Scrapers
  module Minnesota
    class BusinessLicenseScraper < AbstractDOLIScraper
      include ::Sidekiq::Worker
      sidekiq_options queue: :scrapers

      # include Jobs::Lock
      include Jobs::Throttle
      self.throttle_limit = 15.minutes

      @ids = %w[ LicType LicNo AppNo LicStatus ExpDt EffDt OrigDt PrintDt EnforcementAction Name
                Address1 Address2 Phone Fax Other RespLicNo ]


      def perform(c_id, lic_num)
        self.license_number = lic_num
        self.company_id     = c_id

        parse_page

        # Queue up the personal license that was referenced in this one
        if output.resp_lic_no?
          Minnesota::PersonalLicenseScraper.perform_async(company_id, output.resp_lic_no)
        end

        # Save the new license
        ::BusinessLicense.where(
          company_id:       company_id,
          number:           output.lic_no,
          issuing_state_id: Minnesota.id

        ).order('updated_at desc').first_or_initialize.update_attributes!({

          type_id:   output.type_id,
          status_id: output.status_id,

          application_number: output.app_no,

          expires_on:   parse_date(output.exp_dt),
          effective_on: parse_date(output.eff_dt),
          issued_on:    parse_date(output.orig_dt),
          printed_on:   parse_date(output.print_dt),

          enforcement_action: output.enforcement_action,

          name:              output.real_name,
          doing_business_as: output.doing_business_as,

          responsible_person_license_number: output[:resp_lic_no],

          address:      output.address,
          phone_number: output.phone,

          raw_data: output.stringify_keys,

          fetched_at: Time.now
        }, without_protection: true)

        if output.lic_no != license_number.original
          # the format of the license number that was supplied was wrong, but it's been corrected in
          # the new record, so we'll need to delete the old one
          ::BusinessLicense.where(
            company_id:       company_id,
            number:           license_number.original,
            issuing_state_id: Minnesota.id
          ).destroy_all
        end
      end

      def license_type
        :business
      end

    end
  end
end
