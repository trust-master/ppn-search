source 'http://rubygems.org'
ruby File.read(File.expand_path('../.ruby-version' , __FILE__)).gsub(/-p\d+\s*\z/, '')

gem 'rails', '3.2.13'
gem 'rack'

gem 'pg' # Use PostgreSQL

gem 'unicorn', require: false # Use Unicorn to serve the app

gem 'haml' # Write views in HAML

gem 'liquid' # Use liquid templates for User-editable templates, i.e. mailers, pages

gem 'mail' # send mails with ease
gem 'premailer' # make inline the CSS, create text-only versions, more fun stuff

gem 'redcarpet' # Use Markdown to parse Pages / Email templates

gem 'bcrypt-ruby' # To use ActiveModel has_secure_password

gem 'paperclip', '~> 3.3.0'
gem 'fog' # Use AWS for Attachment Storage

gem 'cancan' # very nice API for authorization

# making controllers stupidly clean
gem 'inherited_resources'
gem 'has_scope'
gem 'responders'

gem 'simple_form' # Form builder

gem 'kaminari', # Pagination helpers / scopes
  # path: '../kaminari'
  git: 'https://github.com/rtlong/kaminari.git' # use my fork for I18n action in the helpers

# Texticle enables easy access to native PGSQL full-text searching, also see
# https://github.com/Casecommons/pg_search if this one sucks
gem 'texticle', '2.0.3', require: 'texticle/rails'

gem 'meta_search' # Nifty search scoping tool. Dependency of ActiveAdmin

gem 'squeel', '1.0.13' # convience API for AR-scoping

gem 'counter_culture' # easy counter cache columns

gem 'activeadmin', # Pretty admin interface made easy
  git: 'https://github.com/rtlong/active_admin.git' # my fork, for various fixes / mods
  # path: '../active_admin' # use my local copy as I change stuff

gem 'attribute_normalizer' # Normalize attributes before saving (strip, nullify blanks, custom formatting, etc.)

gem 'surus' # Use PostgreSQL's native Array and HStore data types in AR

gem 'enumerize' # Enumerated attributes made easy

gem 'paper_trail' # Keep a log of previous versions of AR models

gem 'redis' # Connect to Redis in-memory key/value store

# redis-store provides a full set of stores (Cache, I18n, Session, HTTP Cache). It natively supports
# object marshalling, timeouts, single or multiple nodes and namespaces.
git 'https://github.com/jodosha/redis-store.git' do # using the source,
  gem 'redis-store' # wrapper gem
  gem 'redis-rails' # provides a Rails interface to the above
  gem 'redis-i18n' # provides a backend for I18n.
  gem 'redis-rack-cache' # provides a Redis-backed store for Rack::Cache
end

gem 'sidekiq'

# For the screen-scraping component
gem 'nokogiri' # HTML/XML parser
gem 'mechanize' # API wrapper to work with nokogiri more easily

gem 'active_decorator' # Clean up view logic

gem 'content_for_in_controllers' # bring content_for into the controller

gem 'exceptional' # send Exceptions to Exceptional.io

# Compass provides SASS goodies, and some of it's helpers are used in the app code, so it can't be
# in the assets group
gem 'compass-rails'

# These are dependencies of Sidekiq-web:
gem 'slim'
gem 'sinatra', require: false



# Gems used only for assets and not required in production environments by default.
group :assets do
  gem 'sass-rails' # use SASS to write CSS
  gem 'coffee-rails' # use CoffeeScript to write JS
  gem 'uglifier' # compress JS
  gem 'yui-compressor'
  gem 'jquery-rails' # Inject jQuery into the asset pipeline

  # Formalize has some sane defaults for form fields to help them look consistent across multiple platforms
  gem 'formalize-rails'

  # Chosen is still being used, but it's my modified version, so we can't use chosen-rails till my change is merged in
  # gem 'chosen-rails' # chosen provides a nifty jQuery plugin to do empowered <select>s

  # SASS goodies
  gem 'bourbon'

  gem 'oily_png' # C extensions for generating PNGs - used by Compass for the CSS sprites
end

group :production, :stage do
  gem 'newrelic_rpm'
  gem 'newrelic-redis'
end

group :development do
  gem 'thin', require: false # Use thin instead of Unicorn, in development only

  gem 'tailor', require: false # check syntax and code-style against a set of rules
  gem 'checker', require: false

  # Prints db schema tidbits in all the models, tests, and fixtures, also shows `rake routes` output in routes.rb.
  gem 'annotate', require: false

  # https://github.com/guard/guard # http://intridea.com/2011/8/25/hire-a-guard-for-your-project
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-annotate', require: false
  gem 'guard-cucumber', require: false

  gem 'foreman', require: false

  gem 'sass' # This is here so generators can use it

  # gem 'rack-webconsole' # access the rails console right within the web browser

  # generate graphs to represent Models/Classes in the app
  # Use with `bx railroad -a -i -o full_models.dot -M`
  # gem 'railroad', git: 'https://github.com/kirillrdy/railroad3.git'

  gem 'dnote', require: false # To enumerate all TODO's and FIXME's in the code

  # Pry replaces IRB
  gem 'pry-rails' # replace IRB for the rails console, automatically
  gem 'pry-doc' # the libraries needed to view ruby source method-info in Pr

  gem 'populator' # For seeding my dev DB with fake data

  gem 'letter_opener' # Open sent emails in the browser

  gem 'brakeman', require: false

  gem 'zeus', require: false

  gem 'ruby-debug-ide', github: 'ruby-debug/ruby-debug-ide', require: false

end

group :development, :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'factory_girl_rails', require: false
  #gem 'capybara'
  #gem 'launchy'
  #gem 'quiet_assets'
  gem 'faker' # Used in some of the Factories to generate fake data; used in seeds.rb
end


group :development, :stage do
  gem 'replicate', require: false
  gem 'rack-mini-profiler'
end

# The filesystem event and system notifications that Guard wants, for Linux/Unix
gem 'libnotify',    require: false # Visual notifications
gem 'rb-inotify',   require: false # inotify support

