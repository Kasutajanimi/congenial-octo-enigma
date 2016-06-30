class Team
  Member = Struct.new(:name)

  def initialize
    @members = []
  end

  def <<(name)
    @members << Member.new(name)
  end

  def members_names
    @members.map(&:name)
  end

  def print(options = {})
    if options[:printer].nil?
      printer = ProPrinter.new   # ProPrinter is de-facto default printer
    else
      if available_printers.include?(options[:printer])
        printer = self.class.const_get(options[:printer].to_s.capitalize + "Printer").new
        options.delete(:printer)
      else
        raise "Unrecognized printer"
      end
    end

    printer.print(members_names, options)
  end

  private

  def available_printers
    %i( pro reverse presentation funny )
  end
end
