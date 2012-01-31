require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module BusinessFiling
        extend AbstractScraper

        class << self

          def perform(company_id, filing_number)
            url = [MBLS_BASE_URL, { FileNumber: filing_number.strip, Type: 'BeginsWith' }.to_query].join('?')

            page = agent.get(url).link_with(href: %r[Business/SearchDetails/]).click

            props = {}
            props[:business_name] = page.search("//div[@id='recordReview']/h3").text.strip.squish
            props[:last_annual_filing] = page.search("//div[@id='renewal']//td[@class='date']").last.text.strip.squish

            page.search('//dl').collect{ |dl|
              name = dl.search('dt/text()').first.text.strip.gsub('(s)','s').parameterize.underscore.to_sym
              values = dl.search('dd').map{ |n|
                n.text.strip.squeeze(' ').gsub(/(\r\n)+/,"\n")
              }
              props[name] = values.count == 1 ? values.first : values
            }
            props[:registered_agents] = Array.wrap(props[:registered_agents]).reject { |v| /none provided/i.match(v) }

            REDIS[:default].publish 'status', props.to_json
            p props

            ::BusinessFiling.create(
              company_id: company_id,
              type_id: FilingType.find_or_create_by_name(props[:business_type].squish).id,
              status_id: FilingStatus.find_or_create_by_name(props[:status].squish).id,
              number: props[:file_number],
              name: props[:business_name],
              registered_office_address: props[:registered_office_address],
              originally_filed_on: Date.strptime(props[:filing_date], '%m/%d/%Y'),
              in_good_standing_as_of: Date.strptime(props[:last_annual_filing], '%m/%d/%Y'),
              chapter: props[:mn_statute],
              duration: '???',
              agent_name: props[:registered_agents].compact.to_sentence.presence
            )
          end

        end
      end
    end
  end
end