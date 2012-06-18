class ChangeNamesOfCompanyTextColumns < ActiveRecord::Migration
  def up

    %w[
      name
      email
      phone_main
      phone_mobile
      phone_fax
      website_url
      about
      description
      general_info
      insurance_certificate
      insurance_certificate_file_name
      insurance_certificate_content_type
      insurance_certificate_fingerprint
      insurance_certificate_meta
    ].each do |col|
      connection.execute("UPDATE companies SET #{col} = NULL WHERE #{col} = '';")
    end

    rename_column :companies, :description, :benefits
    rename_column :companies, :general_info, :specialty

    add_column    :companies, :description, :text

    # I want to leave the about column in place, as I expect Trust Master to want this short, one-
    # line provider description, for the search results, later on...
    connection.execute("UPDATE companies SET description = about;")
    connection.execute("UPDATE companies SET about = NULL;")

  end

  def down
    connection.execute("UPDATE companies SET about = description;")
    remove_column :companies, :description

    rename_column :companies, :specialty, :general_info
    rename_column :companies, :benefits, :description
  end
end
