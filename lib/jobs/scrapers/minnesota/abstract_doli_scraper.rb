require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module AbstractDOLIScraper
        extend AbstractScraper

        def parse_page(license_type, license_number, ids)

          url = [ DOLI_BASE_URL,
                  { Advanced: 'yes', LicNo: license_number.strip,
                    LicClass: license_type.to_s.titlecase[0..2], Type: 'ALL',
                    Name: nil, City: nil, Zip: nil, Status: 'NONE', PageSize: 10 }.to_query
                ].join('?')

          form = agent.get(url).forms[0]

          # click 'Details' for the first result (should be the _only_ result)
          form['__EVENTARGUMENT'] = 'Select$0'
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

          output[:lic_type] = LicenseType.find_or_create_by_state_id_and_name_and_type(
            State.find_by_name('Minnesota').id,
            output[:lic_type].titlecase,
            "#{license_type.to_s.titlecase}LicenseType"
          )

          output[:lic_status] = LicenseStatus.find_or_create_by_name(output[:lic_status].titlecase)

          [:ce_status, :name, :relation_name, :address1].each do |k|
            output[k] = output[k].titlecase if output[k]
          end

          if output[:address2]
            output[:address2].gsub!(/([\s\w]+\w)\s*,\s*([A-Z]{2})\s*(\d{5}(?:-\d{4})?)/i){ |m|
              "#{$1.titlecase}, #{$2.upcase} #{$3}"
            }
          end

          output.keys.grep(/_(dt|exp|orig)$/).each do |k|
            output[k] = Date.strptime(output[k], '%m/%d/%Y') if output[k].presence
          end

          return output
        end

      end
    end
  end
end