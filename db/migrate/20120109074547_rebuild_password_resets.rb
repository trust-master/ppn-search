class RebuildPasswordResets < ActiveRecord::Migration
  def up
    drop_table :user_password_resets

    create_table :user_auth_tokens, :force => true do |t|
      t.belongs_to :user
      t.string     :token
      t.string   :type
      t.string   :fullfilled_by_ip
      t.datetime :fullfilled_at
      t.datetime :email_sent_at
      t.datetime :expires_at
      t.datetime :created_at
      t.string   :created_by_ip
      t.datetime :updated_at
    end
  end

  def down
    drop_table :user_auth_tokens

    create_table "user_password_resets", :force => true do |t|
      t.integer  "user_id"
      t.string   "token"
      t.string   "requested_by_ip"
      t.datetime "email_sent_at"
      t.datetime "expires_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
