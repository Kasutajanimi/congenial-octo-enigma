require 'spec_helper'
Dir["./lib/*.rb"].each { |file| require file }

describe ReversePrinter do
  let(:team) { Team.new }

  it "ReversePrinter prints members names downcase and in reversed order of letters" do
    team_builder(5)

    output_names = team.members_names.map{ |name| name.reverse.downcase }
    printer = Proc.new(&proc { team.print({ printer: :reverse }) })

    output_names.each do |name|
      expect_any_instance_of(Kernel).to receive(:puts).with(name)
    end

    printer.call
  end

  it "ReversePrinter prints members names in reversed order" do
    team_builder(5)

    output_string = team.members_names.reverse.map{ |name| name.downcase.reverse + "\n" }.join('')

    printer = Proc.new(&proc { team.print({ printer: :reverse }) })

    expect(printer).to output(output_string).to_stdout
  end

  it "ReversePrinter can print unlimited members name" do
    team_builder(25)

    printer = Proc.new(&proc { team.print({ printer: :reverse }) })

    expect_any_instance_of(Kernel).to receive(:puts).exactly(25).times
    printer.call
  end

  it "ReversePrinter receive an array of members and hash of options" do
    team_builder(5)

    expect_any_instance_of(ReversePrinter).to receive(:print).with(kind_of(Array), kind_of(Hash))
    team.print({ printer: :reverse })
  end
end
