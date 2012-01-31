require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module PersonalLicense
        extend AbstractScraper

        IDS = ["LicType", "LicNo", "AppNo", "LicStatus", "ExpDt", "EffDt", "OrigDt", "PrintDt",
        "Enforcement", "EnforcementAction", "CEStatus", "Name", "Address1", "Address2", "Phone",
        "Fax", "Other"]

        class << self

          def perform(filing_number)
            url = [ DOLI_BASE_URL,
              { Advanced: 'yes', LicNo: filing_number.strip, LicClass: 'Per', Type: 'ALL',
                Name: nil, City: nil, Zip: nil, Status: 'NONE', PageSize: 10
              }.to_query
            ].join('?')

            page = agent.get(url)
            form = page.forms[0]

            # select the first result (should be the _only_ result)
            form['__EVENTARGUMENT'] = 'Select$0'
            form['__EVENTTARGET'] = 'gvLicensing'

            form.radiobutton_with(name: 'licenseType', id: 'rbPersonal').checked = true
            form.radiobutton_with(name: 'licenseType', id: 'rbBusiness').checked = false

            page = form.submit

            output = {}

            IDS.each{ |id|
              output[id.underscore] = page.search(".//span[@id='#{id}']").first.try(:text).try(:strip).try(:presence)
            }

            REDIS[:default].publish 'status', output.to_json
            p output
          end

        end
      end
    end
  end
end