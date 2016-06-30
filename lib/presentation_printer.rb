class PresentationPrinter
  # TODO: add multiple presentation options (sort, shuffle, reverse)
  def print(members_names, options = {})
    options[:shuffle].nil? ? shuffle = true : shuffle = options[:shuffle]

    puts "Members:"
    if shuffle
      members_names.shuffle.each { |name| puts "* #{name}" }
    else
      members_names.each { |name| puts "* #{name}" }
    end
  end
end
