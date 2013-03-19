# via http://groups.google.com/group/nanoc/browse_thread/thread/7662340a9d94bd4e/84b47ee2c6f08f15 and https://bitbucket.org/schof/schof.org/

class Time
  def format_as_date
    %[#{Date::MONTHNAMES[self.mon]} #{self.mday.ordinal}, #{self.year}]
  end

  def format_as_date_id
    "#{self.year}-#{self.mon}-#{self.mday}"
  end
end

class Numeric
  def ordinal
    if (10...20).include?(self) then
      self.to_s + 'th'
    else
      self.to_s + %w{th st nd rd th th th th th th}[self % 10]
    end
  end

  # def to_month_name
  #   Date::MONTHNAMES[self]
  # end
end