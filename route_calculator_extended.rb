#Marko Vukadinovic


# Klasse Dijkstra - User Story 4____________________________________________________________
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
# Ende der Klasse Dijkstra - User Story 4___________________________________________________

#US3 Methoden_______________________________________________________________________________

def suche_index ecken, punkt
  ind=-1
  i=-1
  ecken.each do |eck|
    i=i+1
    if eck==punkt
      ind=i
    end
  end
  return ind
end

def vorhanden ecken, punkt
  ind = suche_index ecken, punkt
  if ind>-1
    return true
  else
    return false
  end
end


def moegliche_wege start, ziel, routen, usr_wahl, zw, string, arrY
  if string.length-1 <= zw && usr_wahl != 'min' 
    routen.each do |route|
      if route[0,1] == start
        moegliche_wege route[1,1], ziel, routen, usr_wahl, zw, string+start, arrY
      end
      if route[0,1] == start && route[1,1] == ziel
        string = string + start + ziel
        if usr_wahl == 'gen' && string.length-2 == zw
          arrY.push string
          return arrY
        elsif usr_wahl == 'max' && string.length-2 <= zw
          arrY.push string
          return arrY
        else
          return arrY
        end
      end
    end
    return arrY
  elsif usr_wahl == 'min'
    routen.each do |route|
      g = string.split(//)
      f = false
      g.each do |punkt|
        if punkt == route[1,1] && route[1,1] !=ziel
          f=true
        end
      end
      
      if route[0,1] == start && f==false 
        moegliche_wege route[1,1], ziel, routen, usr_wahl, zw, string+start, arrY
      elsif route[0,1] == start && route[1,1] == ziel && string.length-2 >= zw 
        string = string + start + ziel
        arrY.push string
        return arrY
      end
    end
  end
end
#___________________________________________________________________________________________


# Hausaufgabe 1 -> User Story 01____________________________________________________________
puts ''
puts '********************'
puts '* ROUTENBERECHNER  *'
puts '********************'
puts''
puts 'Geben Sie beliebige Route ein in der Form AB5,BC8,usw: '
route = gets.chomp.upcase
puts''
puts 'Sie haben ' + route + ' eingegeben.'
puts
#___________________________________________________________________________________________

# Hausaufgabe 2 -> User Story 02____________________________________________________________
#
#01 Frag den User nach der beliebigen Route: (puts)
#02 Warte auf Eingabe des Users: (gets)
#03 Eingabe verarbeiten und Bestaetigung ausgeben
#04 Nach der Route im Datencontainer suchen
#05 Falls die Route ungueltig -> Fehlermeldung ausgeben und von vorne anfangen
#sonst addiere gefundene Routen miteinander und das Ergebnis ausgeben (Laenge, Kosten und Name der Route)
#06 Frag den User ob er eine eine andere Route berechen moechte oder QUIT. (pust)
#07 Warte auf Users Antwort (gets)
#08 if (Weiter_machen = true) wiederhole die Schrite 1-5 else terminate the program.

routencontainer=[]  #StringsContainer
laenge_der_route=[] #ZahlenContainer

puts '-------------'
route = route.split(',').sort!
route.each do |stelle|
	puts stelle[0..0] +' -- ' +stelle[2..stelle.length] +' --> ' +stelle[1..1]
	puts '-------------'
	routencontainer << stelle[0..1]
	laenge_der_route << stelle[2..route.length]
end

puts
puts 'Es wurde die Graphdefinition ' +route.to_s+ ' in den Datencontainer eingegeben.'


while true
	puts ''
	puts '::::::::::::::::::::::::::  MENU  ::::::::::::::::::::::::::::::'
	puts ''
	puts '[A-B-C-...] -> Um die Geamtstrecke der Route zu berechnen.'
	puts '[Z] -> Moegliche Wege vom Start zum Ziel (mit Zwischenstationen und Laengen)'
	puts '[K] -> Um den kurzesten Weg zwischen Start und Ziel zu berechnen'
	puts '[Quit] -> Um das Programm zu beenden.'
	puts ''
	puts '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
	puts 'EINGABE: '
	usr_in = gets.chomp
  	puts''

# User Story 4 AUFRUF______________________________________________________________________________
  
if usr_in.downcase == 'k'
	puts '***********************************************************************************************'
	puts '* Hier wird die kuerzeste Strecke zwischen zwei beliebigen "Stationen bzw. Knoten" berechnet. *'
	puts '* Erklaerung: Station oder Knoten bitte in der Form eines Buchstabes eingeben!                *'
	puts '***********************************************************************************************'
	puts 'Gib deinen Start ein und dann druecke ENTER: '
	start = gets.chomp.upcase 
	puts 'Gib dein Ziel ein und dann druecke ENTER:'
	ziel = gets.chomp.upcase 
	exe = Dijkstra.new(route, start) 
	exe.Dijkstra()
	kuerzeste_strecke = exe.finde_kuerzesten_weg(ziel) 
	puts 'Kuerzeste Route von '+start.to_s+' nach '+ziel.to_s+':'
	puts kuerzeste_strecke.join(' -> ')
	puts''
end

# User Story 3 AUFRUF_______________________________________________________________________________  
  
  if usr_in.downcase == 'z'
    ecken = route.collect {|x| x[0,2]}
    ecken.collect! {|x| x.split(//)}
    ecken.flatten!.uniq!.sort!

    puts 'Gib bitte gib einen Startpunkt ein:'
    start = gets.chomp.upcase
    puts 'Gib einen Zielpunkt ein:'
    ziel = gets.chomp.upcase
    
    if (vorhanden ecken, start)==true && (vorhanden ecken, ziel)==true
      puts 'Gib die Anzahl der Zwischenstationen an:'
      zwi = gets.chomp.to_i
      puts''
      
      puts 'Jetzt gib noch an:'
      puts '[min] -> fuer Strecken mit mindestens '+zwi.to_s+' Zwischenstationen'
      puts '[max] -> fuer Strecken mit maximal '+zwi.to_s+' Zwischenstationen'
      puts '[gen] -> fuer Strecken mit genau '+zwi.to_s+' Zwischenstaionen'
      puts ''
      puts'EINGABE: '
      anzahl = gets.chomp.downcase
      puts''
      if (anzahl == 'gen' || anzahl == 'max' || anzahl == 'min') && zwi >= 0
        user_routen = (moegliche_wege start, ziel, route, anzahl, zwi, string= '', arrY= [])
        puts 'Es gibt ' + user_routen.length.to_s + ' moegliche Wege.'
        
        if user_routen.length > 0
          puts 'Routen Zeigen? [J/N]'
          puts'EINGABE: '
          antwort = gets.chomp.upcase
          if antwort == 'J'
            if anzahl.downcase == 'min'
              puts 'Folgende Strecken haben mindestens ' + zwi.to_s + ' Zwischenstationen:'
            elsif anzahl.downcase == 'max'
              puts 'Folgende Strecken haben maximal ' + zwi.to_s + ' Zwischenstationen:'
            elsif anzahl.downcase == 'gen'
              puts 'Folgende Strecken haben genau ' + zwi.to_s + ' Zwischenstationen:'
            end
          
            user_routen.each do |wahl|
              puts wahl.split('').join(' -> ')
            end
            puts''
          end
        end
      
      else
        puts 'Falsche Eingabe.'
      end
      
    else
      puts''
      puts 'Der Startpunkt oder Zielpunkt sind nicht vorhanden.'
    end
  end



if usr_in.downcase == 'quit'
	puts '*******************'
	puts 'PROGRAM TERMINATED.'
	puts '*******************'
	break
end


# User Story 2 AUFRUF_______________________________________________________________________________________
  
  if usr_in.downcase !='k' && usr_in.downcase !='z'
  usr_in = usr_in.upcase.split('-')
  distance = 0;
  counter = 0
  while counter < (usr_in.length - 1)
    x = 0
    gueltige_route = false
    while x < routencontainer.length
      if (usr_in[counter]+usr_in[counter + 1]) == routencontainer[x]
      distance += laenge_der_route[x].to_i
      gueltige_route = true
      break
      end
      x += 1
    end
    if gueltige_route == false
    break
    end
    counter += 1
  end
  if gueltige_route == false
    puts '***Die Route wurde nicht gefunden.'
  else
    puts
    puts 'ROUTE GEFUNDEN!!!'
    puts 'Gesamtstrecke der Route: ' + distance.to_s
  end
  end
end
