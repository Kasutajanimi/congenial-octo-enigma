require 'spec_helper'
Dir["./lib/*.rb"].each { |file| require file }

describe PresentationPrinter do
  let(:team) { Team.new }

  it "PresentationPrinter prints members names prefixed by asterisk" do
    team_builder(5)

    output_names = team.members_names.map{ |name| "* " + name }
    printer = Proc.new(&proc { team.print({ printer: :presentation }) })

    expect_any_instance_of(Kernel).to receive(:puts).with("Members:")
    output_names.each do |name|
      expect_any_instance_of(Kernel).to receive(:puts).with(name)
    end

    printer.call
  end


  it "PresentationPrinter accepts shows constant result order when shuffle is false" do
    team_builder(15)

    non_shuffled_names = team.members_names.map{ |name| "* " + name + "\n" }.join('')

    printer = Proc.new(&proc { team.print({ printer: :presentation, shuffle: false }) })

    expect(printer).to output("Members:\n" + non_shuffled_names).to_stdout
  end

  it "PresentationPrinter receive an array of members and hash of options" do
    team_builder(5)

    expect_any_instance_of(PresentationPrinter).to receive(:print).with(kind_of(Array), kind_of(Hash))
    team.print({ printer: :presentation })
  end
end