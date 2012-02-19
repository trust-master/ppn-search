require 'mechanize'
require 'json'

module Jobs
  module Scrapers
    module Minnesota
      class BusinessFiling < AbstractScraper

        DATE_FORMAT = '%m/%d/%Y'

        def self.perform(company_id, filing_number)
          url = [MBLS_BASE_URL, { FileNumber: filing_number.to_s.strip, Type: 'BeginsWith' }.to_query].join('?')

          page = agent.get(url).link_with(href: %r[Business/SearchDetails/]).click

          props = Hash[
            page.search('//dl').map do |dl|
              name = dl.search('dt').first.text.strip.gsub('(s)','s').parameterize.underscore.to_sym

              values = dl.search('dd').map{ |dd|
                a = dd.search('text()').map{ |t| t.text.strip.squish.presence }.compact.presence
                a.length <= 1 ? a.first : a if a
              }.compact

              [name, values.length <= 1 ? values.first.presence : values.presence]
            end
          ]

          props[:business_name] = page.search("//div[@id='recordReview']/h3").text.strip.squish

          [:filing, :renewal].each do |section|
            props["#{section}_history".to_sym] = Hash[
              page.search("//div[@id='#{section}']//tr").map do |tr|
                values = tr.search("td").map { |v| v.text.strip.squish.presence }

                # if there are more than 2 `td`s, group the extras with the 2nd one
                values.count > 2 ? [values.first, values[1..-1]] : values
              end
            ]
          end

          props[:last_annual_filing_date] = props[:filing_history].keys.last
          props[:registered_agents] = Array.wrap(props[:registered_agents]).reject { |v|
            /none provided/i.match(v)
          }.map(&:presence).compact.presence


          # Save the filing to the database
          ::BusinessFiling.where(
            company_id:       company_id,
            number:           props[:file_number],
            issuing_state_id: State.find_or_create_by_name('Minnesota').id

          ).order('updated_at desc').first_or_initialize.update_attributes!(

            type_id:                   FilingType.find_or_create_by_name(props[:business_type]).id,
            status_id:                 FilingStatus.find_or_create_by_name(props[:status]).id,

            name:                      props[:business_name],

            registered_office_address: flatten_and_join_if_array(props[:registered_office_address]),
            chief_executive_officer:   flatten_and_join_if_array(props[:chief_executive_officer]),
            home_jurisdiction:         props[:home_jurisdiction],

            originally_filed_on:       Date.strptime(props[:filing_date],             DATE_FORMAT),
            last_annually_filed_on:    Date.strptime(props[:last_annual_filing_date], DATE_FORMAT),
            renewal_due_on:            Date.strptime(props[:renewal_due_date],        DATE_FORMAT),

            registered_agents:         props[:registered_agents].try(:to_sentence),

            raw_data:                  props.stringify_keys
          )

          # REDIS[:default].publish 'status', props.to_json
        end

        private

        def self.flatten_and_join_if_array(ary_or_str, joiner = "\n")
          if ary_or_str.is_a?(Array)
            ary_or_str.flatten.compact.join(joiner).presence
          else
            ary_or_str
          end
        end
      end
    end
  end
end