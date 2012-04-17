class MarshalledHash < HashWithIndifferentAccess
  def dump(obj)
    Marshal.dump obj
  end

  def load(dump)
    Marshal.load dump
  end
end