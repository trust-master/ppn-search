require 'faker'
require 'populator'

module Faker
  class Address
    def self.city
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
  class Internet
    def self.domain_name(name = nil)
      [ domain_word(name), domain_suffix ].join('.')
    end
    def self.domain_word(name = nil)
      (name || Company.name).split(/\s+/).join((rand > 0.9) ? '-' : '').gsub(/[^A-Za-z0-9\-]+/, '').downcase
    end
    def self.email(name = nil, domain = nil)
      [ user_name(name), (domain || domain_name) ].join('@')
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

$stdout.sync = true

# Show active record log output
Rails.logger = Logger.new( Rails.root.join('log', 'seed.log') )
ActiveRecord::Base.logger = Rails.logger
conn = ActiveRecord::Base.connection

SEED_DATA = YAML.load_file( Rails.root.join('db','seeds.yml') ).with_indifferent_access.freeze

puts "Seeding Database...\n\n"

########################
print 'Populating Companies... '

SEED_DATA[:companies].each do |name|
  company = Company.find_or_create_by_name(name) do |c|
    domain = Faker::Internet.domain_name(c.name)
    c.admin_email = Faker::Internet.email(Faker::Name.first_name, domain)
    c.website_url = 'http://' + domain
    c.email = Faker::Internet.email(%w[inquire contact info sales].sample, domain)
    c.phone_main = Faker::PhoneNumber.phone_number if (rand > 0.5)
    c.phone_mobile = Faker::PhoneNumber.cell_phone if (rand > 0.5)
    c.in_business_since = Date.civil( (Date.today.year - 3 - rand(5) - 1/(rand+0.0125)).floor )
    c.about = Faker::Lorem.sentences(1, true).join if (rand > 0.5)
    c.description = Faker::Lorem.paragraphs(rand(4), true).join("\n\n") if (rand > 0.5)
    c.general_info = Faker::Lorem.paragraphs(rand(4), true).join("\n\n") if (rand > 0.5)
  end
  print '.'
end
print "\n"
COMPANY_ids = Company.all_ids
success_msg "There are now #{COMPANY_ids.count} Companies"

########################
puts "Populating Locations..."

SEED_DATA[:countries].each do |c|
  country = Country.find_or_create_by_name(c['name'])

  c['states'].each do |s|
    state = State.find_or_create_by_name_and_country_id(s, country.id)
    if state.locations.count < 50 then
      Location.populate(50) do |l|
        l.city = Faker::Address.city
        l.zip  = Faker::Address.zip_code
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
puts 'Populating Markets and Service Areas...'

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

#######################
print 'Populating Users... '

admin = User.find_or_initialize_by_email('ryan@rtlong.com').tap do |u|
  u.first_name, u.middle_name, u.last_name = %w'Ryan Taylor Long'
  u.password_digest = BCrypt::Password.create('test')
  u.role = 'Admin'
  u.save validate: false, as: :admin
end
print 'A'

if Admin.count < 10
  Admin.populate(10) do |u|
    u.first_name, u.middle_name, u.last_name = name = [
      Faker::Name.first_name,
      (rand > 0.9) ? Faker::Name.first_name : nil,
      Faker::Name.last_name
    ]
    u.email = "#{[u.first_name, u.last_name].join('.')}@Trust-Master.com"
    u.password_digest = BCrypt::Password.create('test')
  end
  print 'A' * 10
end
ADMIN_ids = Admin.all_ids

Company.all.each do |c|
  company_admin = User.find_or_initialize_by_role_and_company_id('CompanyAdmin', c.id).tap do |u|
    unless u.persisted?
      u.first_name, u.middle_name, u.last_name = name = [
        Faker::Name.first_name,
        (rand > 0.9) ? Faker::Name.first_name : nil,
        Faker::Name.last_name
      ]
      u.email = Faker::Internet.email(name.compact.join(' '), c.email.split('@').last)
      u.password_digest = BCrypt::Password.create('test')
      u.created_by_user_id = u.updated_by_user_id = ADMIN_ids.sample
      u.role = 'CompanyAdmin'
      u.save validate: false, as: :admin
    end
    print 'C'

    c.update_attributes :admin_email => u.email
  end

  if c.users.count < 2
    quant = rand(10)
    User.populate(quant) do |u|
      u.first_name, u.middle_name, u.last_name = name = [
        Faker::Name.first_name,
        (rand > 0.9) ? Faker::Name.first_name : nil,
        Faker::Name.last_name
      ]
      u.email = Faker::Internet.email(name.compact.join(' '), c.email.split('@').last)
      u.password_digest = BCrypt::Password.create('test')
      u.company_id = c.id
      u.created_by_user_id = u.updated_by_user_id = company_admin.id
      print '.'
    end
  end
end
print "\n"

USER_ids = User.all_ids

success_msg "There are now #{Admin.count} Admin users, #{User.where(role: 'CompanyAdmin').count}
Company Admins, and #{User.count} total users."