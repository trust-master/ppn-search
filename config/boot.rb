require 'rubygems'

# These lines were removed by rake rails:update
# require 'yaml'
# YAML::ENGINE.yamler = 'syck'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# This should be removed, but it's the only way!!!
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
