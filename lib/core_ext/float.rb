class Float
  def to_hhmmss
    hours, seconds  = self.divmod(3600)
    minutes, seconds = seconds.divmod(60)
  
    if hours.zero?
      if minutes.zero?
        sprintf "%02.1fs", seconds
      else
        sprintf "%02dm %02.1fs", minutes, seconds
      end
    else
      sprintf "%02dh %02dm %02.1fs", hours, minutes, seconds      
    end
  end
end