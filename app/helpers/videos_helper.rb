module VideosHelper
  def nice_time(seconds)
    [(seconds/60).to_s, (seconds%60).to_s].join(':')
  end
end
