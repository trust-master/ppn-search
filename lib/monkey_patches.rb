# This file contains monkey patches for use in development environments only.

module Faker
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