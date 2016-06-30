class ProPrinter
  def print(members_names, options = {})
    options[:limit].nil? ? limit = 10 : limit = options[:limit]

    members_names.take(limit).each { |name| puts name.capitalize }
  end
end
