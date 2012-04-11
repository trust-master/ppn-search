ActiveAdmin.register Page do

  filter :content

  index do
    selectable_column
    column :title do |p|
      link_to p.title, [:admin, p]
    end
    column :slug do |p|
      link_to p.slug, p.path
    end
    column :name
    default_actions
  end

  show(title: :title) do |p|
    attributes_table do
      row :name
      row :slug do
        link_to p.slug, p.path
      end
      row :title do
        h2 p.title
      end
      row :content do
        p.render_content
      end
      # row :published
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  action_item only: [:edit, :show] do
    link_to(t('.view_in_app'), page.path)
  end

  form do |f|
    f.inputs do
      f.input :name, hint: 'This is what is referenced in the code, for inserting links to this page in menus, etc. It may not be changed after page creation. It must contain only alphanumeric characters and underscores (<code>_</code>), and must begin with a letter. This is a unique identifier amongst the all pages.'.html_safe, input_html: { disabled: f.object.persisted? }
      f.input :slug, hint: 'This is the URL path to this page. (<code>http://trust-master.herokuapp.com/{slug}</code>). This can be changed at any time, but must consist only of alphanumeric and the following characters: <code>_$@.,&+/\-!*"\'()</code>. This is a unique identifier amongst the all pages.'.html_safe
      f.input :title, hint: 'This is the <code>&lt;title&gt;</code> of the page. It will be automatically inserted into the body of the page, used to construct links to this page, and it will show as the document title on the top of the browser window/tab, and in search results (i.e. Google / Bing).'.html_safe
      f.input :content, hint: 'The content of the page. This will be formatted with <a href="http://daringfireball.net/projects/markdown/syntax">Markdown</a>.'.html_safe
      # f.input :published
    end
    f.buttons
  end

  controller do
    cache_sweeper :page_sweeper
  end
end
