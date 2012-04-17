class AddEmailTemplatesTable < ActiveRecord::Migration
  def change
    create_table :email_templates, id: false do |t|
      t.column :id, 'varchar(255) primary key'
      t.string :display_name
      t.text   :headers # serialized headers hash
      t.text   :body
      t.binary :template # the Marshalled Liquid template
      t.timestamps
    end
  end
end
