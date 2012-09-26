class String
  def not_a_positive_float?
    self !~ /^\s*[+]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
  end
  
  def not_a_positive_int?
    self !~ /^\s*[+]?\d+\s*$/
  end
end