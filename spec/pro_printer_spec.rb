require 'spec_helper'
Dir["./lib/*.rb"].each { |file| require file }

describe ProPrinter do
  let(:team) { Team.new }

  it "ProPrinter prints members names starting with capital letter" do
    5.times do
      team << ("rand_name_" + SecureRandom.hex)
    end

    capitalised_names = team.members_names.map{ |name| name.capitalize }
    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    capitalised_names.each do |name|
      expect_any_instance_of(Kernel).to receive(:puts).with(name)
    end

    printer.call
  end

  it "ProPrinter print all names if up to 10 member names given" do
    5.times do
      team << ("rand_name_" + SecureRandom.hex)
    end

    capitalised_names = team.members_names.map{ |name| name.capitalize }
    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    expect_any_instance_of(Kernel).to receive(:puts).exactly(5).times
    printer.call
  end

  it "ProPrinter cannot print more then 10 names" do
    15.times do
      team << ("rand_name_" + SecureRandom.hex)
    end

    capitalised_names = team.members_names.map{ |name| name.capitalize }
    printer = Proc.new(&proc { team.print({ printer: :pro }) })

    expect_any_instance_of(Kernel).to receive(:puts).exactly(10).times
    printer.call
  end
end