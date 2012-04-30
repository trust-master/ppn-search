module ValidationPatterns
  # all legal characters for email mailbox name (excluding the \.)
  email_user_chars = "[:alnum:]!$%&'*+\/=?^_`{|}~-"

  # limit mailbox id to email_user_chars unless it's wrapped in double quotes
  EmailUser = /[#{email_user_chars}]+(?:\.?[#{email_user_chars}])*|".+?"/iu.freeze

  # this expression defines all current valid TLDs # FIXME: This is only accurate for TLD in a latin script. There are valid TLDs that would be expressed in other scripts. This was last checked/updated 2010-02-10. It is missing a few...
  TopLevelDomain = /a(?:ero|(?:rp|si)a|[cdefgilmnoqrstuwxz])|b(?:iz|[abdefghijmnorstwyz])|c(?:at|o(?:m|op)|[acdfghiklmnoruvxyz])|d[ejkmoz]|e(?:du|[cegrstu])|f[ijkmor]|g(?:ov|[adefghilmnpqrstuwy])|h[kmnrtu]|i(?:n(?:fo|t|[delmnoqrst]))|j(?:obs|[emop])|k[eghimnprwyz]|l[abcikrstuvy]|m(?:il|obi|useum|[acdeghklmnopqrstuvwxyz])|n(?:ame|et|[acefgilopruz])|o(?:m|rg)|p(?:ro|[aefghklmnrstwy])|qa|r[eosuw]|s[abcdeghiklmnrtuvyz]|t(?:(?:rav)?el|[cdfghjklmnoprtvwz])|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw]/iu.freeze

  # this matches any valid domain name # FIXME: Add support for valid unicode URLs.
  DomainName = /(?:[[:alnum:]](?:\-?[[:alnum:]]){0,62}\.)+(?:#{TopLevelDomain.source})/iu.freeze

  # this matches any legal ip address
  IPv4Address = /\A
      (?:
        2(?:5[0-5]|[0-4][0-9])|
        [01]?[0-9]{1,2}
      )(?:\.
        (?:
          2(?:5[0-5]|[0-4][0-9])|
          [01]?[0-9]{1,2}
        )
      ){3}
    \Z/iux.freeze

  # matches any IP address that isn't in one of the reserved ranges
  PublicIPv4Address = /
      (?!10(?:\.\d{1,3}){3})
      (?!127(?:\.\d{1,3}){3})
      (?!169\.254(?:\.\d{1,3}){2})
      (?!192\.168(?:\.\d{1,3}){2})
      (?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})
      (?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))
    /iux.freeze

  # this matches any valid public email address
  EmailAddress = /\A
      (?:#{EmailUser.source})\@
      (?:
        (?:#{DomainName.source})|
        \[(?:#{PublicIPv4Address.source})\]
      )
    \Z/iux.freeze

  URL = Url = %r~\A
      https?://(?:
        (?:#{DomainName.source})|
        (?:#{PublicIPv4Address.source})
      )
      (?::\d{2,5})?
      (?:/[^\s]*)?
    \Z~iux.freeze

  ImageContentTypes = %r[
      image/(
        p?jpeg|
        (x-)?png|
        gif|
        tiff|
        svg\+xml
      )|
      application/pdf
    ]iux.freeze
  AcceptableUploadTypes = [*ImageContentTypes].freeze
end