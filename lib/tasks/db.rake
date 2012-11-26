namespace :db do

  task :reload_from_dump => ['drop', 'create'] do

    puts 'Run the following commands to pull in the dump:',
         '  $ psql -W -f db/structure.sql ServiceProviderPortal_development TrustMaster',
         '  $ psql -W -f tmp/data_dump/dump.sql ServiceProviderPortal_development TrustMaster'


  end

end