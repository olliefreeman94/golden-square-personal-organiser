require "date"

class Task
  def initialize(task, deadline)
    @task = task
    @deadline = Date.parse(deadline.to_s)
    @complete = false
  end
  
  def task
    return @task
  end

  def deadline
    return @deadline.to_s
  end

  def done?
    return @complete
  end

  def mark_done!
    @complete = true
  end
end