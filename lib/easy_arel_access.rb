# This is nothing more than an alias, `t`, to the arel_table method, which allows easy use of Arel
# for things like querying and sorting, a la:
#
#   default_scope reorder(t[:date].desc, t[:sort_order].desc, t[:id].desc)
#
module EasyArelAccess
  def t
    self.arel_table
  end
end