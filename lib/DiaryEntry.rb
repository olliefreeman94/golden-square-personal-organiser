require "date"

class DiaryEntry
  def initialize(date = Date.today, contents)
    @date = Date.parse(date.to_s)
    @contents = contents
  end
  
  def date
    return @date.to_s
  end

  def contents
    return @contents
  end

  def count_words
    return @contents.split(" ").length
  end

  def contacts
    return @contents.split(" ").join("").scan(/[0-9]{11}/)
  end
end