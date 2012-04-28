# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rails' do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(/Gemfile(?:.lock)?/)
end

# guard 'resque', environment: 'development', task: 'resque:work', verbose: false, trace: false,
#                 queue: '*', count: 1

guard 'resque', environment: :development, verbose: true, trace: true, queue: [:mailers, :scrapers, '*'].join(',') do
  watch(%r{^app/(.+)\.rb})
  watch(%r{^lib/(.+)\.rb})
end

guard 'spork', cucumber_env: { 'RAILS_ENV' => 'test' }, rspec_env: { 'RAILS_ENV' => 'test' } do
  watch(%r{^config/(?:application|environment|routes).rb$})
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(/Gemfile(?:.lock)?/)
  watch('spec/spec_helper.rb') { :rspec }
  watch(%r{features/support/}) { :cucumber }
end

guard 'annotate', tests: true, position: :top  do
  watch( 'db/schema.rb' )
end

guard 'cucumber', cli: '--profile guard' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^(?:app|lib|config)/.+$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  end
end

# guard 'rails_best_practices' do
#   watch(%r{^app/(.+)\.rb$})
# end

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_(?:spec|factory)\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
   [
     "spec/routing/#{m[1]}_routing_spec.rb",
     "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
     "spec/acceptance/#{m[1]}_spec.rb"
   ]
  end
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

# Add files and commands to this file, like the example:
#   watch('file/path') { `command(s)` }
#
# guard 'shell' do
#   watch('config/routes.rb') { IO.popen('annotate -r') { |f| puts f.gets } }
# end

# guard 'bundler' do
#   watch('Gemfile.lock')
# end
