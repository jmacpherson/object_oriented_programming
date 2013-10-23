class RoutesGraph
  @@routes = {:A => {:B => 5, :D => 5, :E => 7}, :B => {:C => 4}, :C => {:D => 8, :E => 2}, :D => {:C => 8, :E => 6}, :E => {:B => 3}}

  def self.distance(start, *stops)
    total_distance = 0
    current_town = start
    stops.each do |stop|
      return "NO SUCH ROUTE" if @@routes[current_town][stop] == nil
      total_distance += @@routes[current_town][stop]
      current_town = stop
    end

    return total_distance
  end
end

# Distance Tests

puts RoutesGraph.distance(:A,:B,:C)
puts RoutesGraph.distance(:A,:D)
puts RoutesGraph.distance(:A,:D,:C)
puts RoutesGraph.distance(:A,:E,:B,:C,:D)
puts RoutesGraph.distance(:A,:E,:D)

# Number of Routes Tests