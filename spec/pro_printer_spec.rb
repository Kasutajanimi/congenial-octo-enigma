require 'spec_helper'
Dir["./lib/*.rb"].each { |file| require file }

describe ProPrinter do
  let(:team) { Team.new }

  it "ProPrinter prints members names starting with capital letter" do
    team_builder(5)

    output_names = team.members_names.map{ |name| name.capitalize }
    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    output_names.each do |name|
      expect_any_instance_of(Kernel).to receive(:puts).with(name)
    end

    printer.call
  end

  it "ProPrinter print all names if up to 10 member names given" do
    team_builder(5)

    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    expect_any_instance_of(Kernel).to receive(:puts).exactly(5).times
    printer.call
  end

  it "ProPrinter cannot print more then 10 names" do
    team_builder(15)

    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    expect_any_instance_of(Kernel).to receive(:puts).at_most(10).times
    printer.call
  end

  it "ProPrinter receive an array of members and hash of options" do
    team_builder(5)

    expect_any_instance_of(ProPrinter).to receive(:print).with(kind_of(Array), kind_of(Hash))
    team.print({ printer: :pro })
  end
end