module Helpers
  def team_builder(memebrs_count)
    memebrs_count.times do
      team << ("rand_name_" + SecureRandom.hex)
    end
  end
end