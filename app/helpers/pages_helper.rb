module PagesHelper

  def page_path(name)
    REDIS[:cache].sadd(:page_names_to_suggest_for_creation, name)

    Page.slug_map[name]
  end

end