require 'faker'
require 'populator'
require 'open-uri'
require 'nokogiri'
require 'mechanize'
require Rails.root.join('lib','monkey_patches.rb')

def success_msg( msg )
  puts "  => \033[1;32m#{msg}\033[m"
end
def error_msg( msg )
  puts " !=> \033[1;31m#{msg}\033[m"
end

$stdout.sync = true

# Show active record log output
Rails.logger = Logger.new(Rails.root.join('log', 'seed.log'))
ActiveRecord::Base.logger = Rails.logger
conn = ActiveRecord::Base.connection

SEED_DATA = YAML.load_file(Rails.root.join('db','seeds.yml')).with_indifferent_access.freeze

puts "Seeding Database...\n\n"


########################
puts "Populating Countries / States..."

SEED_DATA[:countries].each do |c|
  country = Country.where(name: c['name'], abbreviation: c['code']).first_or_create!({}, without_protection: true)

  c['states'].each do |abbr, name|
    state = State
      .where(name: name, abbreviation: abbr, country_id: country.id)
      .first_or_create!({}, without_protection: true)
  end
end

COUNTRY_ids = Country.pluck(:id)
success_msg "There are now #{COUNTRY_ids.count} Countries."
STATE_ids = State.pluck(:id)
success_msg "There are now #{STATE_ids.count} States."

US_id = Country.where(name: 'United States').pluck(:id).first
MN_id = State.where(name: 'Minnesota').pluck(:id).first

########################
print 'Administrator Users... '

admin = User.find_or_initialize_by_email('ryan@rtlong.com').tap do |u|
  u.first_name, u.middle_name, u.last_name = %w'Ryan Taylor Long'
  u.password_digest = BCrypt::Password.create('aoe123#')
  u.role = 'Administrator'
  u.active = true
  u.save!(validate: false, without_protection: true)
end
print 'A'

User.current_user = admin

admins = {
  %w'Dan Modeen'  => 'dmodeen@trust-master.com',
  %w'Mike Pennaz' => 'mpennaz@trust-master.com',
  %w'Gary Bursey' => 'gbursey@trust-master.com',
  %w'Matt Pennaz' => 'mpennaz@gmail.com'
}
admins.each do |name, email|
  u = Administrator.where(email: email).first_or_initialize
  u.first_name, u.last_name = name
  u.password_digest = BCrypt::Password.create('test123!')
  u.active = true
  u.save!(validate: false, without_protection: true)
  print 'A'
end
ADMIN_ids = Administrator.pluck(:id)

exit unless Rails.env == 'development'

########################
print 'Populating Markets and Service Areas...'

SEED_DATA[:service_areas].each do |s|
  market = Market.where(name: s['market']).first_or_create!({}, without_protection: true)
  print ' +'
  s['service_areas'].each do |a|
    market.service_areas.where(name: a).first_or_create!({}, without_protection: true)
    print '.'
  end
end
print "\n"

MARKET_ids = Market.pluck(:id)
success_msg "There are now #{MARKET_ids.count} Markets."
SERVICE_AREA_ids = ServiceArea.pluck(:id)
success_msg "There are now #{SERVICE_AREA_ids.count} ServiceAreas."

########################
print 'Populating Categories...'

SEED_DATA[:categories].each do |s|
  c = Category.where(name: s['name']).first_or_create!({}, without_protection: true)
  print ' +'
  s['sub_categories'].each do |a|
    c.sub_categories.where(name: a).first_or_create!({}, without_protection: true)
    print '.'
  end
end
print "\n"

CATEGORIES_ids = Category.pluck(:id)
success_msg "There are now #{CATEGORIES_ids.count} Categories."
SUB_CATEGORIES_ids = SubCategory.pluck(:id)
success_msg "There are now #{SUB_CATEGORIES_ids.count} SubCategories."

########################
puts "Populating DiscountTypes..."

SEED_DATA[:discount_types].each do |t|
  country = DiscountType.where(name: t).first_or_create!({}, without_protection: true)
end

DISCOUNT_TYPE_ids = DiscountType.pluck(:id)
success_msg "There are now #{DISCOUNT_TYPE_ids.count} Discount Types."

########################
print 'Populating Companies... '

SEED_DATA[:companies].each do |name|
  company = Company.where(name: name).first_or_create!({}, without_protection: true) do |c|
    domain              = Faker::Internet.domain_name(c.name)
    c.website_url       = 'http://' + domain
    c.email             = Faker::Internet.email(%w[inquire contact info sales].sample, domain)
    c.phone_main        = Faker::PhoneNumber.phone_number if (rand > 0.9)
    c.phone_mobile      = Faker::PhoneNumber.phone_number if (rand > 0.5)
    year = (Date.today.year - rand(5) - 1/(rand + 0.0125)).floor
    c.in_business_since = year
    c.about             = Faker::Lorem.sentences(1, true).join if (rand > 0.5)
    c.description       = Faker::Lorem.paragraphs(rand(4), true).join("\n\n") if (rand > 0.8)
    c.general_info      = Faker::Lorem.paragraphs(rand(4), true).join("\n\n") if (rand > 0.8)
    c.active =  rand > 0.5
    c.visible = rand > 0.5
  end
  if company.locations.empty? then
    Location.populate(rand(5)) do |l|
      l.city       = Faker::Address.city
      l.zip        = 55000 + rand(999) # random MN-like zip-code
      l.country_id = US_id
      l.state_id   = MN_id
      l.company_id = company.id
    end
  end
  if company.categories.empty? then
    sub_category_ids = SUB_CATEGORIES_ids.dup.shuffle
    CompanyCategory.populate(rand(10)) do |c|
      c.company_id = company.id
      c.sub_category_id = sub_category_ids.shift
    end
  end
  if company.service_areas.empty? then
    service_area_ids = SERVICE_AREA_ids.dup.shuffle
    CompanyServiceArea.populate(rand(15)) do |c|
      c.company_id = company.id
      c.service_area_id = service_area_ids.shift
      c.partial_only = rand > 0.5
    end
  end
  print '.'
end

tm = Company.where(name: 'Trust Master').first_or_create!({}, without_protection: true) do |c|
  c.website_url       = 'http://trust-master.com'
  c.email             = 'info@trust-master.com'
  c.phone_main        = '763.213.0700'
  c.phone_fax         = '763.576.1585'
  c.in_business_since = 2000
  c.about             = 'Expert Home Management'
  c.description       = <<-DESC.strip_heredoc
    Homeowners rely on Trust Master to deliver a personalized home management solution that's handled
    seamlessly from a single trusted source.

    Our personal and professional approach begins with an inventory of your specific needs, continues
    with unparalleled service and ends with your total satisfaction.

    eHomeManage is the key to our service promise to you as a valued Trust Master client. It is a home
    management system and online home resource center you won't want to live without.
  DESC
  c.general_info      = <<-GENERAL_INFO.strip_heredoc
    Our clients trust us to manage their home as though it were our own. Trust Master is recommended
    by the Better Business Bureau serving Minnesota and North Dakota and is a licensed general
    contractor (#20506673) that protects your investment by carrying general liability insurance and a
    fidelity bond.
  GENERAL_INFO

  c.active =  rand > 0.5 ? true : false
  c.visible = rand > 0.5 ? true : false
end
tm.locations.where(city: 'Champlin').first_or_create!({state_id: MN_id, zip: '55316'}, without_protection: true)
TM_id = tm.id

print "\n"
COMPANY_ids = Company.pluck(:id)
success_msg "There are now #{COMPANY_ids.count} Companies"
LOCATION_ids = Location.pluck(:id)
success_msg "There are now #{LOCATION_ids.count} Locations."

#######################
print 'Populating Users... '

Company.all.each do |c|
  a = User.where(role: 'CompanyAdmin', company_id: c.id).first_or_initialize

  if a.new_record?
    name = [
      Faker::Name.first_name,
      (rand > 0.9) ? Faker::Name.first_name : nil,
      Faker::Name.last_name
    ]
    a.first_name, a.middle_name, a.last_name = name
    a.email = Faker::Internet.email(name.compact.join(' '), c.email.split('@').last)
    a.password_digest = BCrypt::Password.create('test123!')
    a.created_by_user_id = a.updated_by_user_id = ADMIN_ids.sample
    a.role = 'CompanyAdmin'
    a.active = rand > 0.5 ? true : false
    a.save!(validate: false, without_protection: true)
  end
  print 'C'

  if c.users.count < 2
    quant = rand(10)
    User.populate(quant) do |u|
      u.first_name, u.middle_name, u.last_name = name = [
        Faker::Name.first_name,
        (rand > 0.9) ? Faker::Name.first_name : nil,
        Faker::Name.last_name
      ]
      u.email = Faker::Internet.email(name.compact.join(' '), c.email.split('@').last)
      u.password_digest = BCrypt::Password.create('test123!')
      u.company_id = c.id
      u.created_by_user_id = u.updated_by_user_id = User.current_user.id
      u.active = rand > 0.5 ? true : false
      print '.'
    end
  end
end
print "\n"

USER_ids = User.pluck(:id)

success_msg "There are now #{Administrator.count} Administrator users, #{User.where(role: 'CompanyAdmin').count} " <<
  "Company Administrators, and #{User.count} total users."

#######################
puts "\nPopulating License types from the MN DLI License Lookup Page...\n"

agent = Mechanize.new

print '  Getting Personal License Types... '

options = begin
    page = agent.get('https://secure.doli.state.mn.us/lookup/AdvancedSearch.aspx')
    print '!'
    page.parser.xpath("//select[@name='ddlLicType']/option[not(@value='ALL')]/text()").map{ |node|
      node.to_s.strip.downcase.titleize.gsub(/\b(Ce|Hpp)\b/){ |word| word.upcase }
    }
  rescue Exception => e
    # Load from YAML
    print 'Error, falling back to YAML'
    SEED_DATA[:license_types][:mn][:personal]
  end

options.each do |license_type|
  PersonalLicenseType.where(name: license_type, state_id: MN_id).first_or_create!({}, without_protection: true)
  print '.'
end

print "\n  Getting Business License Types... "
options = begin
    form = page.form('form1')
    form.radiobutton_with(name: "licenseType", value: "rbBusiness").check
    page = form.submit
    print '!'

    page.parser.xpath("//select[@name='ddlLicType']/option[not(@value='ALL')]/text()").map{ |node|
      node.to_s.strip.split('-').map{ |s|
        s.downcase.titleize.gsub(/\b(Ce|Hpp)\b/){ |word| word.upcase }
      }.join('-')
    }
  rescue Exception => e
    # Load from YAML
    print 'Error, falling back to YAML'
    SEED_DATA[:license_types][:mn][:business]
  end

options.each do |license_type|
  BusinessLicenseType.where(name: license_type, state_id: MN_id).first_or_create!({}, without_protection: true)
  print '.'
end
print "\n"

success_msg "There are now #{PersonalLicenseType.count} types of PersonalLicense " <<
  "and #{BusinessLicenseType.count} types of BusinessLicense"
