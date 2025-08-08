module SizeMultiplier
  def self.for(size)
    case size
    when "Small" then 0.7
    when "Medium" then 1.0
    when "Large" then 1.3
    else 1.0
    end
  end
end
