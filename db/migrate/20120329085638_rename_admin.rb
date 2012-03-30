# this is to deal with the name collision with ActiveAdmin
class RenameAdmin < ActiveRecord::Migration
  def up
    User.where(role: 'Admin').update_all(role: 'Administrator')
  end

  def down
    User.where(role: 'Administrator').update_all(role: 'Admin')
  end
end
