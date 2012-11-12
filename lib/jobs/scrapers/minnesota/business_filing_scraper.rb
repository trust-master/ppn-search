require 'mechanize'
require 'json'

module Jobs::Scrapers
  module Minnesota
    class BusinessFilingScraper < AbstractScraper
      include Sidekiq::Worker
      sidekiq_options queue: :scrapers

      # include Jobs::Lock
      include Jobs::Throttle
      self.throttle_limit = 15.minutes

      DATE_FORMAT = '%m/%d/%Y'

      def perform(*args)
        company_id, filing_number, args = *args
        if /\A\s*[a-z0-9\-]+\s*\Z/i.match(filing_number).nil?
          raise ArgumentError, 'filing_number is invalid!'
        end
        if ::Company.where(id: company_id).none?
          raise ArgumentError, 'company_id is invalid!'
        end

        url = [
          MBLS_BASE_URL,
          { FileNumber: filing_number.to_s.strip, Type: 'BeginsWith' }.to_query
        ].join('?')

        page = agent.get(url).link_with(href: %r[SearchDetails]).tap{ |link|
          raise NoResultsError, "No results were found for filing_number: #{filing_number}" if link.nil?
        }.click

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

        if props.count < 5
          raise SanityCheckFailedError, "details page for #{filing_number} did not look as it should"
        end

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

        props[:last_annual_filing_date] = props[:renewal_history].keys.last
        props[:registered_agents] = Array.wrap(props[:registered_agents]).reject { |v|
          /none provided/i.match(v)
        }.map(&:presence).compact.presence


        # Save the filing to the database
        ::BusinessFiling.where(
          company_id:       company_id,
          number:           props[:file_number],
          issuing_state_id: Minnesota.id

        ).order('updated_at desc').first_or_initialize.update_attributes({

          type_id:                   ::FilingType.find_or_create_by_name(props[:business_type]).id,
          status_id:                 ::FilingStatus.find_or_create_by_name(props[:status]).id,

          name:                      props[:business_name],

          registered_office_address: flatten_and_join_if_array(props[:registered_office_address]),
          chief_executive_officer:   flatten_and_join_if_array(props[:chief_executive_officer]),
          home_jurisdiction:         props[:home_jurisdiction],

          originally_filed_on:       parse_date(props[:filing_date]),
          last_annually_filed_on:    parse_date(props[:last_annual_filing_date]),
          renewal_due_on:            parse_date(props[:renewal_due_date]),

          registered_agents:         props[:registered_agents].try(:to_sentence),

          raw_data:                  props.stringify_keys,

          fetched_at: Time.now

        }, without_protection: true)


        if filing_number != props[:file_number]
          ::BusinessFiling.where(
            company_id:       company_id,
            number:           filing_number,
            issuing_state_id: Minnesota.id
          ).destroy_all
        end
      end

      private

      def flatten_and_join_if_array(ary_or_str, joiner = "\n")
        if ary_or_str.is_a?(Array)
          ary_or_str.flatten.compact.join(joiner).presence
        else
          ary_or_str
        end
      end

      def parse_date(date_string)
        if date_string.present?
          Date.strptime(date_string, DATE_FORMAT)
        end
      end

    end
  end
end