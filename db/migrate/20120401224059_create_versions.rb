class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string   :item_type,     :null => false
      t.integer  :item_id,       :null => false
      t.string   :event,         :null => false
      t.integer  :whodunnit
      t.text     :object
      t.text     :object_changes
      t.datetime :created_at,    :null => false

      t.boolean  :published # for Pages, etc. so we can have an unpublished version
      t.string   :ip_address
      t.string   :controller_name # the controller that was used to save this version (Admin / Front-End ?)
    end
    add_index :versions, [:item_type, :item_id]
  end

  def self.down
    remove_index :versions, [:item_type, :item_id]
    drop_table :versions
  end
end
