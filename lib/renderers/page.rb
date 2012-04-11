module Renderers
  class Page < Redcarpet::Render::SmartyHTML
    def header(text, level)
      level += 2
      %[<h#{level}>#{text}</h#{level}>]
    end
  end
end
