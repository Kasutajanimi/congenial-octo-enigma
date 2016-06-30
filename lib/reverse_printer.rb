class ReversePrinter
  def print(members_names, options = {})
    members_names.reverse.each { |name| puts name.reverse.downcase }
  end
end
