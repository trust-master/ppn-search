# module Paperclip
#   module Schema
#     # The has_attached_file helper for migrations should include the fingerprint and meta attributes
#     COLUMNS.update(fingerprint: :string, meta: :text)

#     # redefine these methods to skip adding/removing columns when unneccesary; thus preventing
#     # errors from a partial migration
#     def has_attached_file(attachment_name)
#       with_columns_for(attachment_name) do |column_name, column_type|
#         if column_exists?(column_name)
#           puts("Skipping #{column_name}; already exists")
#         else
#           column(column_name, column_type)
#         end
#       end
#     end
#     def drop_attached_file(table_name, attachment_name)
#       with_columns_for(attachment_name) do |column_name, column_type|
#         if column_exists?(table_name, column_name)
#           remove_column(table_name, column_name)
#         else
#           puts("Skipping #{column_name}; does not exist")
#         end
#       end
#     end
#   end
# end