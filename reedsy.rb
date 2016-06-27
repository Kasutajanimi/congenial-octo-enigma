class Team
  Member = Struct.new(:name)

  attr_accessor :printer

  def initialize(printer = ProPrinter.new)
    @members = []
    @printer = printer
  end

  def <<(name)
    @members << Member.new(name)
  end

  def members_names
    @members.map(&:name)
  end

  def print(*args)
    if args.nil?
      printer.print(members_names)
    else
      printer.print(members_names, *args)
    end
  end
end

class ProPrinter
  def print(members_names, limit = 10)
    members_names.take(limit).each { |name| puts name.capitalize }
  end
end

class ReversePrinter
  def print(members_names)
    members_names.reverse.each { |name| puts name.reverse.downcase }
  end
end

class PresentationPrinter
  # TODO: add multiple presentation options (sort, shuffle, reverse)
  def print(members_names, shuffle = true)
    puts "Members:"
    if shuffle
      members_names.shuffle.each { |name| puts "* #{name}" }
    else
      members_names.each { |name| puts "* #{name}" }
    end
  end
end

class FunnyPrinter
  def print(members_names)
    # TODO: not implemented
  end
end
