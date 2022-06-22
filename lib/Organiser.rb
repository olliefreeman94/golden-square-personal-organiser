require "date"

class Organiser
  def initialize
    @entries = []
    @tasks = []
  end
  
  def add_entry(entry)
    @entries << entry
  end

  def add_task(task)
    @tasks << task
  end

  def all_entries
    return @entries.sort_by { |entry| entry.date }
  end

  def select_entry(wpm, minutes)
    fail "Reading speed and minutes must be greater than zero." if wpm <= 0 || minutes <= 0
    readable_amount = wpm * minutes
    readable_entries = @entries.select { |entry| entry.count_words <= readable_amount }
    return readable_entries.sort_by { |entry| entry.count_words }.last
  end

  def all_contacts
    all_contacts = []
    @entries.each { |entry| all_contacts += entry.contacts }
    return all_contacts
  end

  def outstanding_tasks
    outstanding_tasks = @tasks.reject { |entry| entry.done? }
    return outstanding_tasks.sort_by { |entry| entry.deadline }
  end

  def completed_tasks
    outstanding_tasks = @tasks.select { |entry| entry.done? }
    return outstanding_tasks.sort_by { |entry| entry.deadline }.reverse
  end
end