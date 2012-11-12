module Jobs::Scrapers
  module Minnesota
    class AbstractDOLIScraper < AbstractScraper
      class LicenseNumber
        LICENSE_NUMBER_PATTERN = /\A\s*(\w[A-Z])\s*(\d{1,6})\s*\Z/i

        attr_reader :original

        def initialize(number)
          @original = number

          LICENSE_NUMBER_PATTERN.match(number) or raise ArgumentError, 'License Number is invalid!'

          # Make sure the license_number is in the normalized format
          @license_number = number.gsub(LICENSE_NUMBER_PATTERN){ |m|
            [$1, '%06d' % $2.to_i].join.upcase
          }
        end

        def to_s
          @license_number.to_s
        end
      end
    end
  end
end
