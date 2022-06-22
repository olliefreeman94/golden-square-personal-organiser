require "Organiser"
require "DiaryEntry"
require "Task"

RSpec.describe "organiser integration" do
  context "when diary entries have been added" do
    it "returns a list of diary entries, sorted by date" do
      organiser = Organiser.new
      entry1 = DiaryEntry.new("diary entry for today")
      entry2 = DiaryEntry.new("2022-06-01", "diary entry for 1st June")
      organiser.add_entry(entry1)
      organiser.add_entry(entry2)
      expect( organiser.all_entries ).to eq [entry2, entry1]
    end

    it "returns longest readable entry" do
      organiser = Organiser.new
      entry1 = DiaryEntry.new("one")
      entry2 = DiaryEntry.new("one two three")
      entry3 = DiaryEntry.new("one two three four five")
      organiser.add_entry(entry1)
      organiser.add_entry(entry2)
      organiser.add_entry(entry3)
      expect( organiser.select_entry(2, 2) ).to eq entry2
    end

    it "returns phone numbers from diary entries" do
      organiser = Organiser.new
      entry1 = DiaryEntry.new("07000 000001")
      entry2 = DiaryEntry.new("text 07000000002 07000 000003")
      organiser.add_entry(entry1)
      organiser.add_entry(entry2)
      expect( organiser.all_contacts ).to eq ["07000000001", "07000000002", "07000000003"]
    end
  end

  context "when only outstanding tasks have been added" do
    it "returns a list of oustanding tasks, sorted by deadline" do
      organiser = Organiser.new
      task1 = Task.new("Mow the lawn", "2022-06-26")
      task2 = Task.new("Walk the dog", "2022-06-23")
      organiser.add_task(task1)
      organiser.add_task(task2)
      expect( organiser.outstanding_tasks ).to eq [task2, task1]
      expect( organiser.completed_tasks ).to eq []
    end
  end

  context "when tasks have been added, and some have been marked as done" do
    it "returns sorted lists of outstanding and complete tasks" do
      organiser = Organiser.new
      task1 = Task.new("Mow the lawn", "2022-06-26")
      task2 = Task.new("Walk the dog", "2022-06-23")
      organiser.add_task(task1)
      organiser.add_task(task2)
      task1.mark_done!
      expect( organiser.outstanding_tasks ).to eq [task2]
      expect( organiser.completed_tasks ).to eq [task1]
    end
  end

  context "when all added tasks have been marked as done" do
    it "returns list of completed tasks, reverse sorted by deadline" do
      organiser = Organiser.new
      task1 = Task.new("Mow the lawn", "2022-06-26")
      task2 = Task.new("Walk the dog", "2022-06-23")
      organiser.add_task(task1)
      organiser.add_task(task2)
      task1.mark_done!
      task2.mark_done!
      expect( organiser.completed_tasks ).to eq [task1, task2]  
    end
  end
end