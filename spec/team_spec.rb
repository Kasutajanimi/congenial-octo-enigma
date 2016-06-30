require 'spec_helper'
Dir["./lib/*.rb"].each { |file| require file }

describe Team do
  let(:team) { Team.new }

  it "Team initialize with empty members list" do
    initial_members = team.instance_variable_get(:@members)

    expect(initial_members).to eq([])
  end

  it "Team can add memebrs" do
    add_members = Proc.new(&proc {
      team_builder(5)
    })

    expect(add_members).to change{team.members_names.count}.from(0).to(5)
  end

  it "Team can print member names" do
    team_builder(5)

    expect(team).to receive(:print)
    team.print
  end

  it "By default ProPrinter is used" do
    team_builder(5)

    expect_any_instance_of(ProPrinter).to receive(:print)
    team.print
  end
end