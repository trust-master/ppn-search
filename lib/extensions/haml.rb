#module Haml
#
#  module Filters::Markdown
#    include Filters::Base
#    lazy_require "redcarpet"
#
#    def render(text)
#      @renderer ||= Redcarpet::Render::SmartyHTML.new
#      @parser ||= Redcarpet::Markdown.new(@renderer, autolink: true)
#      @parser.render(text)
#    end
#  end
#
#end
