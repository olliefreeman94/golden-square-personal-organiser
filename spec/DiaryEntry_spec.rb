require "DiaryEntry"

RSpec.describe DiaryEntry do
  it "adds diary entry with today's date when no date provided" do
    entry = DiaryEntry.new("diary entry for today")
    expect( entry.date ).to eq "2022-06-22"
    expect( entry.contents ).to eq "diary entry for today"
  end

  it "adds diary entry when date is provided" do
    entry = DiaryEntry.new("2022-06-01", "diary entry for 1st June")
    expect( entry.date ).to eq "2022-06-01"
    expect( entry.contents ).to eq "diary entry for 1st June"
  end

  it "adds diary entry when date provided in different format" do
    entry = DiaryEntry.new("1st June 2022", "diary entry for 1st June")
    expect( entry.date ).to eq "2022-06-01"
  end

  it "returns word count 0 for empty string" do
    entry = DiaryEntry.new("")
    expect( entry.count_words ).to eq 0
  end

  it "returns correct word count for given contents" do
    entry = DiaryEntry.new("one two three")
    expect( entry.count_words ).to eq 3
  end

  it "returns an empty list if no phone numbers found in contents" do
    entry = DiaryEntry.new("text text text")
    expect( entry.contacts ).to eq []
  end

  it "returns a list of phone numbers from contents" do
    entry = DiaryEntry.new("text 07000000002 07000 000003")
    expect( entry.contacts ).to eq ["07000000002", "07000000003"]
  end  
end