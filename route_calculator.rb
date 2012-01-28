#Marko Vukadinovic
#Matrikel-Nummer:2085118
#Media Systems - WiSe 2011/12
#In dieser Datei ::: User Story 1, 2 und 4

# W I C H T I G !!!!! 

require '/home/marek/Desktop/user story/Dijkstra.rb' # W I C H T I G !!! Der Pfad der Dijkstra Klasse unter dem Debian Linux 6. 
# Im Debian Linux muss man den ganzen Pfad eingeben. Ich habe auch versuchr mit der Command require '.Dijkstra.rb' wobei die beiden Dateien in einem gemeinsamen Ordner ->
# -> gewesen sind. Hat aber nicht geklappt. Ich weiss auch dass Sie Mac OSx haben und weiss nicht wie das unter dem Mac funktioniert.
#Warscheinlich werden Sie den Pfad der Klasse Dijkstra.rb aendern mussen.

# Hausaufgabe 1 -> User Story 01____________________________________
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
#__________________________________________________________________

# Hausaufgabe 2 -> User Story 02_________________________________________________________________________
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
	puts '[K] -> Um den kurzesten Weg zwischen Start und Ziel zu berechnen'
	puts '[Quit] -> Um das Programm zu beenden.'
	puts ''
	puts '::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'
	puts 'EINGABE: '
	usr_in = gets.chomp
  	puts''

# User Story 4___________________________________________________________________
  
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
#_______________________________________________________________________________  
  
if usr_in.downcase == 'quit'
	puts '*******************'
	puts 'PROGRAM TERMINATED.'
	puts '*******************'
	break
end


#In weiterem Code wird die Strecke der Route Geprueft und ausgegeben
  if usr_in.downcase !='k'
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
