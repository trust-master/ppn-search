# Use Redis for translations store, fall back to YAML
# I18n.backend = I18n::Backend::Chain.new(
#   I18n::Backend::Redis.new(ServiceProviderPortal::Application.config.redis_urls[:i18n]),
#   I18n.backend
# )









# I18n.module_eval do
#   class << self

#     def translate_with_show_keys(key, options = {})
#       keys = normalize_keys(locale, key, options[:scope]).join('.')

#       translation = translate_without_show_keys(key, options)
#       p key, caller.grep(/simple_form.+(?!simple_form_for)/)
#       if caller.grep(/simple_form.+(?!simple_form_for)/).any? or translation.try(:match, /translation.missing/)
#         return translation
#       end

#       if options[:rescue_format] == :html
#         %[#{translation}<dfn>#{keys}</dfn>].html_safe
#       else
#         "#{translation} [#{keys}]"
#       end
#     end
#     alias_method_chain :translate, :show_keys

#     alias_method :t_without_show_keys, :t
#     alias_method :t, :translate_with_show_keys

#   end
# end