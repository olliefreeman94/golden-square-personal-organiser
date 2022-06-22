# Organiser Multi Class Planned Design Recipe

## 1. Describe the Problem

_As a user
So that I can record my experiences
I want to keep a regular diary

As a user
So that I can reflect on my experiences
I want to read my past diary entries

As a user
So that I can reflect on my experiences in my busy day
I want to select diary entries to read based on how much time I have and my reading speed

As a user
So that I can keep track of my tasks
I want to keep a todo list along with my diary

As a user
So that I can keep track of my contacts
I want to see a list of all of the mobile phone numbers in all my diary entries_

## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
┌───────────────────────────────────────────┐
│                                           │
│  Organiser                                │
│  ---------                                │
│                                           │
│  - add_entry                              │
│  - add_task                               │
│  - all_entries                            │
│  - select_entry                           │
│  - all_contacts                           │
│  - outstanding_tasks                      │
│  - completed_tasks                         │
│                                           │
├──────────────────────┬────────────────────┘
│                      │
│                      ▼
│    ┌──────────────────────────────────────┐
│    │                                      │
│    │  DiaryEntry                          │
│    │  ----------                          │
│    │                                      │
│    │  - date                              │
│    │  - contents                          │
│    │  - count_words                       │
│    │  - contacts                          │
│    │                                      │
│    └──────────────────────────────────────┘
│
│    ┌──────────────────────────────────────┐
│    │                                      │
│    │  Task                                │
│    │  ----                                │
│    │                                      │
└──► │  - deadline                          │
     │  - task                              │
     │  - done?                             │
     │  - mark_done!                        │
     │                                      │
     └──────────────────────────────────────┘
```

_Also design the interface of each class in more detail._

```ruby
class Organiser
  def add_entry(entry) # entry is an instance of DiaryEntry
  end

  def add_task(task) # entry is an instance of Task
  end

  def all_entries
    # Return @entries list, sorted by DiaryEntry date
  end

  def select_entry(wpm, minutes) # integers
    # Return longest readable instance of DiaryEntry
  end

  def all_contacts
    # Return list of phone numbers
  end

  def outstanding_tasks
    # Return list of incomplete Tasks
  end

  def completed_tasks
    # Return list of completed Tasks
  end
end

class DiaryEntry
  def date
    # Return date as string
  end

  def contents
    # Return contents as string
  end

  def count_words
    # Return no. of words in contents as integer
  end

  def contacts
    # Return list of phone numbers from contents
  end
end

class Task
  def deadline
    # Return deadline date as string
  end

  def task
    # Return task as string
  end

  def done?
    # Return boolean
  end

  def mark_done!
    # Return nothing
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# 1
organiser = Organiser.new
entry1 = DiaryEntry.new("diary entry for today")
entry2 = DiaryEntry.new("2022-06-01", "diary entry for 1st June")
organiser.add_entry(entry1)
organiser.add_entry(entry2)
organiser.all_entries => [entry2, entry1]

# 2
organiser = Organiser.new
entry1 = DiaryEntry.new("one")
entry2 = DiaryEntry.new("one two three")
entry3 = DiaryEntry.new("one two three four five")
organiser.add_entry(entry1)
organiser.add_entry(entry2)
organiser.add_entry(entry3)
organiser.select_entry(2, 2) => entry2

# 3
organiser = Organiser.new
entry1 = DiaryEntry.new("07000 000001")
entry2 = DiaryEntry.new("text 07000000002 07000 000003")
organiser.add_entry(entry1)
organiser.add_entry(entry2)
organiser.all_contacts => ["07000000001", "07000000002", "07000000003"]

# 4
organiser = Organiser.new
task1 = Task.new("2022-06-26", "Mow the lawn")
task2 = Task.new("2022-06-23", "Walk the dog")
organiser.add_task(task1)
organiser.add_task(task2)
organiser.outstanding_tasks => [task2, task1]

# 5
organiser = Organiser.new
task1 = Task.new("2022-06-26", "Mow the lawn")
task2 = Task.new("2022-06-23", "Walk the dog")
organiser.add_task(task1)
organiser.add_task(task2)
task1.mark_done!
organiser.outstanding_tasks => [task2]
organiser.completed_tasks => [task1]

# 6
organiser = Organiser.new
task1 = Task.new("2022-06-26", "Mow the lawn")
task2 = Task.new("2022-06-23", "Walk the dog")
organiser.add_task(task1)
organiser.add_task(task2)
task1.mark_done!
task2.mark_done!
organiser.completed_tasks => [task1, task2]
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# Organiser
# EXAMPLE

# 1
organiser = Organiser.new
organiser.all_entries => []
# organiser.select_entry => nil
organiser.all_contacts => []
organiser.outstanding_tasks => []
organiser.completed_tasks => []

# 2
organiser = Organiser.new
organiser.select_entry(0, 0) throws an error: "Reading speed and minutes must be greater than zero."

# DiaryEntry
# EXAMPLE

# 1
entry = DiaryEntry.new("diary entry for today")
entry.date => today
entry.contents => "diary entry for today"

# 2
entry = DiaryEntry.new("2022-06-01", "diary entry for 1st June")
entry.date => "2022-06-01"
entry.contents => "diary entry for 1st June"

# 3
entry = DiaryEntry.new("1st June 2022", "diary entry for 1st June")
entry.date => "2022-06-01"

# 4
entry = DiaryEntry.new("")
entry.count_words => 0

# 5
entry = DiaryEntry.new("one two three")
entry.count_words => 3

# 6
entry = DiaryEntry.new("text text text")
entry.contacts => [] # || nil

# 7
entry = DiaryEntry.new("text 07000000002 07000 000003")
entry.contacts => ["07000000002", "07000000003"]

# Task
# EXAMPLE

# 1
task = Task.new("2022-06-23", "Walk the dog")
task.deadline => "2022-06-23"
task.task => "Walk the dog"
task.done? => false

# 2
task = Task.new("23rd June 2022", "Walk the dog")
task.deadline => "2022-06-23"

# 3
task = Task.new("2022-06-23", "Walk the dog")
task.mark_done!
task.done? => true
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test driving process of red, green,
refactor to implement the behaviour._
