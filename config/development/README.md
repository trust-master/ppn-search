This folder is meant to contain config files for the external tools that need to run during
development, such as Redis, and ElasticSearch. The entries in the Procfile will reference the
files here, and these configs are set up to log and store their data as per the Rails standard:
#{Rails.root}/log/#{binary_name} and #{Rails.root}/tmp/#{binary_name}, respectively.

These files will not be used in any production environment, they are merely here to enable use of foreman to handle running all dependent software during development.
