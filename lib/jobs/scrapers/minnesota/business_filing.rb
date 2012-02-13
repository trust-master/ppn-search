require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      module BusinessFiling
        extend AbstractScraper

        class << self

          def perform(company_id, filing_number)
            url = [MBLS_BASE_URL, { FileNumber: filing_number.to_s.strip, Type: 'BeginsWith' }.to_query].join('?')

            page = agent.get(url).link_with(href: %r[Business/SearchDetails/]).click

            # props = {}

            # page.search('//dl').collect{ |dl|
            #   name = dl.search('dt/text()').first.text.strip.gsub('(s)','s').parameterize.underscore.to_sym
            #   values = dl.search('dd').map{ |n|
            #     n.text.strip.squeeze(' ').gsub(/(\r\n)+/,"\n")
            #   }
            #   props[name] = values.count == 1 ? values.first : values
            # }

            props = Hash[
              page.search('//dl').map{ |dl|
                name = dl.search('dt').first.text.strip.gsub('(s)','s').parameterize.underscore.to_sym
                values = dl.search('dd').map{ |dd|
                  a = dd.search('text()').map{ |t| t.text.strip.squish.presence }.compact.presence
                  a.length <= 1 ? a.first : a if a
                }.compact
                [name, values.length <= 1 ? values.first.presence : values.presence]
              }
            ]

            props[:business_name] = page.search("//div[@id='recordReview']/h3").text.strip.squish
            props[:last_annual_filing] = page.search("//div[@id='renewal']//td[@class='date']").last.text.strip.squish
            props[:registered_agents] = Array.wrap(props[:registered_agents]).reject { |v|
              /none provided/i.match(v)
            }.map(&:presence).compact.presence

            REDIS[:default].publish 'status', props.to_json

            y props

            ::BusinessFiling.create(
              company_id: company_id,
              type_id: FilingType.find_or_create_by_name(props[:business_type]).id,
              status_id: FilingStatus.find_or_create_by_name(props[:status]).id,
              number: props[:file_number],
              name: props[:business_name],
              registered_office_address: props[:registered_office_address].try(:join, "\n"),
              originally_filed_on: Date.strptime(props[:filing_date], '%m/%d/%Y'),
              in_good_standing_as_of: Date.strptime(props[:last_annual_filing], '%m/%d/%Y'),
              chapter: props[:mn_statute],
              agent_name: props[:registered_agents].try(:to_sentence)
            )
          end

        end
      end
    end
  end
end