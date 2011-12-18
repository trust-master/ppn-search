require 'faker'
require 'populator'

module Faker
  class Address
    def city
      case rand(4)
      when 1
        '%s %s%s' % [city_prefix, Name.first_name, city_suffix]
      when 2
        [city_prefix, Name.first_name].join(' ')
      when 3
        [Name.first_name, city_suffix].join
      when 4
        [Name.last_name, city_suffix].join
      end
    end
  end
end
module ActiveRecord
  class Base
    def self.all_ids
      connection.select_values("SELECT id FROM #{table_name};")
    end
  end
end
def success_msg( msg )
  puts "  => \033[1;32m#{msg}\033[m"
end
def error_msg( msg )
  puts " !=> \033[1;31m#{msg}\033[m"
end

# Show active record log output
Rails.logger = Logger.new( Rails.root.join('log', 'seed.log') )
ActiveRecord::Base.logger = Rails.logger
conn = ActiveRecord::Base.connection

SEED_DATA = YAML.load_file( Rails.root.join('db','seeds.yml') ).symbolize_keys.freeze
########################
puts "\n\nSeeding Database...\n\n"

########################
puts "Populating Companies... "

SEED_DATA[:companies].each { |name| Company.find_or_create_by_name(name) }
COMPANY_ids = Company.all_ids

success_msg "There are now #{COMPANY_ids.count} Companies"

########################
puts "Populating Locations..."
SEED_DATA[:countries].each do |c|
  country = Country.find_or_create_by_name(c['name'])
  p country

  c['states'].each do |s|
    state = State.find_or_create_by_name_and_country_id(s, country.id)
    p state
    if state.locations.count < 50 then
      Location.populate( 50 ) do |l|
        l.city   = Faker::Address.city
        l.zip = Faker::Address.zip_code
        l.country_id = country.id
        l.state_id = state.id
        l.company_id = COMPANY_ids
      end
    end
  end
end

COUNTRY_ids = Country.all_ids
success_msg "There are now #{COUNTRY_ids.count} Countries."
STATE_ids = State.all_ids
success_msg "There are now #{STATE_ids.count} States."
LOCATION_ids = Location.all_ids
success_msg "There are now #{LOCATION_ids.count} Locations."

########################

SEED_DATA[:service_areas].each do |s|
  market = Market.find_or_create_by_name s['market']
  s['service_areas'].each do |a|
    ServiceArea.find_or_create_by_name_and_market_id a, market.id
  end
end

MARKET_ids = Market.all_ids
success_msg "There are now #{MARKET_ids.count} Markets."
SERVICE_AREA_ids = ServiceArea.all_ids
success_msg "There are now #{SERVICE_AREA_ids.count} ServiceAreas."
