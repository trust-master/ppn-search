module PagesHelper

  def page_info(name)
    REDIS[:cache].sadd(:page_names_to_suggest_for_creation, name)

    Page.meta_map[name]
  end

end