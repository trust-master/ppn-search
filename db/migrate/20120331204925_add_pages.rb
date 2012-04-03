class AddPages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string  :name # :code_of_conduct
      t.string  :slug # /about/code_of_conduct
      t.string  :title # 'Code of Conduct'
      t.text    :content # body of the page, as HTML with liquid templates
      t.boolean :published, nil: false, default: false # whether to show the page to the internet or just to TM admins
    end

    add_index :pages, :name, unique: true
    add_index :pages, :slug, unique: true
  end

  def down
    remove_index :pages, :name
    remove_index :pages, :slug
    drop_table :pages
  end
end
