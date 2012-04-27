module StyleHelper

  def hidden_if(boolean)
    { style: boolean ? 'display: none' : nil }
  end

end