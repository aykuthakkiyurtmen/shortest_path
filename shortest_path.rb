def calculate_shortest_path(graph, start, finish)
  cost = nil
  visited = {}
  visited_cities = []
  finish_neighbour = graph[finish]
  shortest_cities = {}

  while true
    result = graph[start].keys & finish_neighbour.keys

    if result.present? && !visited.present?
      result.each do |city|
        cost = graph[city].select { |n| n == start || n == finish }.values.inject(:+)
        shortest_cities["#{city}"] = cost
      end

      break
    end

    unless result.blank?
      last_city = graph[result.first]
      node_price = visited.to_a.last
      cost = last_city[start] + visited.values.inject(:+) + last_city[node_price.first]
      visited_cities.push(visited.keys, result)

      break
    end

    visited.store(finish_neighbour.keys[0], finish_neighbour.values[0])
    finish_neighbour = finish_neighbour.map { |n| graph[n[0]] }
    finish_neighbour = finish_neighbour.first
  end

  if shortest_cities.blank?
    text = visited_cities.flatten.join(', ')
    p "toplam ucret: #{cost}, ziyaret edilen sehirler: #{text}"

    return
  end

  shortest_cities = shortest_cities.min
  "eger bir node ile ulasilabiliyorsa, en ucuz maliyetli en kisa yol icin node:
  #{shortest_cities.first} toplam ucret: #{shortest_cities.last}"
end


graph = {
  'Memphis' => {'Nashville' => 15, 'New Orleans' => 3, 'Atlanta' => 10, 'Mobile' => 7},
  'Nashville' => {'Memphis' => 15, 'Atlanta' => 2},
  'New Orleans' => {'Memphis' => 3, 'Mobile' => 3},
  'Atlanta' => {'Memphis' => 10, 'Nashville' => 2, 'Mobile' => 2, 'Savannah' => 1},
  'Mobile' => {'Memphis' => 7, 'New Orleans' => 3,  'Atlanta' => 2, 'Savannah' => 6,},
  'Savannah' => {'Atlanta' => 1, 'Mobile' => 6},
}

graph1 = {
  'Atlanta' => {'Nashville' => 2, 'Mobile' => 2, 'Savannah' => 1},
  'Memphis' => {'Nashville' => 15, 'New Orleans' => 3},
  'Nashville' => {'Memphis' => 15, 'Atlanta' => 2},
  'New Orleans' => {'Memphis' => 3, 'Mobile' => 3},
  'Mobile' => {'New Orleans' => 3,  'Atlanta' => 2, 'Savannah' => 6},
  'Savannah' => {'Atlanta' => 1, 'Mobile' => 6},
}

# varis noktasindan onceki ilk node'lardan biri ile direk baslangic noktasina baglaniyor ise
# en dusukmaliyetli ve olan yolu bulur
calculate_shortest_path(graph, 'Memphis', 'Savannah')

#varis noktasindan onceki n katmanlardan ulasiyor ise ilk noktaya, en kisa yolu bulur
calculate_shortest_path(graph1, 'Memphis', 'Savannah')