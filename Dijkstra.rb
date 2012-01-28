#Marko Vukadinovic

# Klasse Dijkstra
class Dijkstra 	
	
	def initialize (route, start) 
		@graph = route
		@entf = {}
		@vorg = {}
		@ok = {}
		@nodeArray = addnode()
		@nodeArray.each do |nd| 
			@entf[nd] = route.length.to_i * 2
			@vorg[nd] = nil	 
			@ok[nd] = false	 
		end
		@entf[start] = 0		
		@vorg[start] = nil	
	end

	def Dijkstra 
		while @ok.length != 0
			u = kleinste_distance()
			@ok.delete(u)
			@graph.each do |rte| 
				if u == rte[0..0] 
					v = rte[1..1] 
					l = rte[2..rte.length] 
					distance_update(u, v, l)
				end
			end
		end
	end
	
	def addnode()
    ndArray = [] 
    @graph.each do |rte| 
      nd1 = rte[0..0] 
      nd2 = rte[1..1] 
      ndArray = ndArray  | [nd1,nd2]
    end
    return ndArray
    
  end
	
	def kleinste_distance
		kleinste_distance = 9999
		index = ''
		@nodeArray.each do |nd|
			if @entf[nd] < kleinste_distance && @ok[nd] == false
				index = nd 
				kleinste_distance = @entf[nd] 
			end
		end
		return index
	end
 
 	def distance_update(u, v, l) 
 		tmp = @entf[u]+l.to_f 
 		if tmp < @entf[v]
 			@entf[v] = tmp
 			@vorg[v] = u
 		end
 	end
	
	def finde_kuerzesten_weg(ziel)
		weg = [ziel]
		u = ziel
		while @vorg[u] != nil
			u = @vorg[u]
			weg = [u] + weg
		end
		return weg
	end
	
end 
# Ende der Klasse Dijkstra
