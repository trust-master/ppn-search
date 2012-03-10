module Jobs
  module Scrapers
    module Minnesota
      DOLI_BASE_URL = 'https://secure.doli.state.mn.us/lookup/Licensing.aspx'
      MBLS_BASE_URL = 'http://mblsportal.sos.state.mn.us/Business/BusinessSearch'

      def self.id
        @@id ||= State.where(name: 'Minnesota').pluck(:id).first
      end

    end
  end
end