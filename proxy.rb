require 'forwardable'

class MachineProxy
  extend Forwardable

  def_delegators :real_entity, :add

  def initialize(hero)
    @hero = hero
  end

  def execute
    check_access
    real_entity.execute
  end

  def check_access
    unless @hero.keywords.include?(:have_access)
      raise "Access not permitted"
    end
  end

  def real_entity
    @real_entity || (@real_entity = Machine.new)
  end

end

class Machine
  attr_reader :queue

  def initialize
    @queue = []
  end

  def add(instruction)
    @queue << instruction
  end

  def execute
    queue.inject("\n") { |result, instruction| result + instruction.execute + "\n" }
  end
end

class Player
  attr_accessor :keywords

  def initialize
    @keywords = []
  end
end
