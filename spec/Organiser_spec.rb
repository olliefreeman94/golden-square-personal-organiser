require "Organiser"

RSpec.describe Organiser do
  it "constructs" do
    organiser = Organiser.new
    expect( organiser.all_entries ).to eq []
    expect( organiser.select_entry(1, 1) ).to eq nil
    expect( organiser.all_contacts ).to eq []
    expect( organiser.outstanding_tasks ).to eq []
    expect( organiser.completed_tasks ).to eq []
  end

  it "returns an error for invalid reading rate or minutes" do
    organiser = Organiser.new
    expect{ organiser.select_entry(0, 0) }.to raise_error "Reading speed and minutes must be greater than zero."
  end
end