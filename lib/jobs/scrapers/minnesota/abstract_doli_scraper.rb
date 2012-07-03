require 'mechanize'
require 'json'

module Jobs::Scrapers
  module Minnesota
    class AbstractDOLIScraper < AbstractScraper

      DATE_FORMAT = '%m/%d/%Y'
      LICENSE_NUMBER_PATTERN = /\A\s*(\w[A-Z])\s*(\d{1,6})\s*\Z/i

      def parse_page(license_type, license_number, ids)
        # Make sure the license_number is in the normalized format
        license_number.gsub!(LICENSE_NUMBER_PATTERN){ |m| [$1, '%06d' % $2.to_i].join.upcase }

        url = [ DOLI_BASE_URL,
                { Advanced: 'yes', LicNo: license_number, DiscType: 'ALL', DiscVal: nil,
                  LicClass: license_type.to_s.titlecase[0..2], Type: 'ALL',
                  Name: nil, City: nil, Zip: nil, Status: 'NONE', PageSize: 10 }.to_query
              ].join('?')

        page = agent.get(url)
        if page.search(%{//td//*[contains(text(), "#{license_number}")]}).empty?
          raise NoResultsError, "No results were found for license_number: #{license_number}"
        end

        form = page.forms[0]

        # these fields are set normally by the __doPostBack function at the bottom of the rendered page
        form['__EVENTARGUMENT'] = 'Select$0' # click 'Details' for the first result (should be the _only_ result)
        form['__EVENTTARGET'] = 'gvLicensing'

        form.radiobutton_with(name: 'licenseType', id: 'rbPersonal').checked = (license_type == :personal)
        form.radiobutton_with(name: 'licenseType', id: 'rbBusiness').checked = (license_type == :business)

        page = form.submit

        output = Hash.new

        ids.each do |id|
          if node = page.search(".//span[@id='#{id}']").first
            output[id.underscore.to_sym] = node.text.try(:strip).presence
          end
        end

        if output.count < 5
          raise SanityCheckFailedError, "details page for #{license_number} did not look as it should"
        end

        output[:type_id] = LicenseType.where(
          state_id: Minnesota.id,
          name: output[:lic_type].titlecase,
          type: "#{license_type.to_s.titlecase}LicenseType"
        ).first_or_create!.id

        output[:status_id] = LicenseStatus.find_or_create_by_name(output[:lic_status].titlecase).id

        [:ce_status, :name].each do |k|
          output[k] = output[k].titlecase if output[k]
        end

        output[:enforcement_action] = output[:enforcement_action] == 'YES'

        if output[:address2]
          output[:address2].gsub!(/([\s\w]+\w)\s*,\s*([A-Z]{2})\s*(\d{5}(?:-\d{4})?)/i) do |m|
            "#{$1.titlecase}, #{$2.upcase} #{$3}"
          end
        end
        output[:address] = [output[:address1], output[:address2]].compact.join("\n").presence

        return output
      end

      private

      def parse_date(date_string)
        if date_string.present?
          Date.strptime(date_string, DATE_FORMAT)
        end
      end

    end
  end
end