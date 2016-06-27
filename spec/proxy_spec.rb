require 'spec_helper'
require_relative '../proxy'

describe "ProxyPattern" do

  it "delegates all functions to real entity" do
    player = Player.new
    machine = double("machine", queue: [], add: [], execute: true)

    allow(Machine).to receive(:new).and_return(machine)
    proxy = MachineProxy.new(player)

    expect(machine).to receive(:add)
    proxy.add(double("instruction"))

    player.keywords << :have_access
    expect(machine).to receive(:execute)

    proxy.execute
  end

end
