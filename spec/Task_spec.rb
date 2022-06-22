require "Task"

RSpec.describe Task do
  it "adds tasks as not complete" do
    task = Task.new("Walk the dog", "2022-06-23")
    expect( task.task ).to eq "Walk the dog"
    expect( task.deadline ).to eq "2022-06-23"
    expect( task.done? ).to eq false
  end

  it "adds tasks with differently formatted dates" do
    task = Task.new("Walk the dog", "23rd June 2022")
    expect( task.deadline ).to eq "2022-06-23"
  end

  it "marks tasks as done" do
    task = Task.new("Walk the dog", "2022-06-23")
    task.mark_done!
    expect( task.done? ).to eq true
  end
end