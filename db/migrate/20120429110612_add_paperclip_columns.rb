require_relative '../../lib/extensions/paperclip/schema'

class AddPaperclipColumns < ActiveRecord::Migration
  ATTACHMENTS = [
      [:discounts, :attachment],
      [:companies, :insurance_certificate],
      [:certifications, :attachment]
  ]

  def up
    ATTACHMENTS.each do |table, attribute|
      change_table table do |t|
        t.has_attached_file attribute
      end
    end
  end

  def down
    ATTACHMENTS.each do |table, attribute|
      drop_attached_file table, attribute
    end
  end

end
