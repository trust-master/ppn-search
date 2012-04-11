class AddRenderedContentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :rendered_content, :text
  end
end