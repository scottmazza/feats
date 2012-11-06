class String
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  def is_valid_email?
    self =~ VALID_EMAIL_REGEX
  end
  
  def not_a_positive_float?
    self !~ /^\s*[+]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
  end
  
  def not_a_positive_int?
    self !~ /^\s*[+]?\d+\s*$/
  end
  
  def possessive
    self + case self[-1,1].downcase
        when 's' then "'"
        else "'s"
        end
  end
end