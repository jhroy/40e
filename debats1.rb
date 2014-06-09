#!/usr/bin/env ruby

require "nokogiri"
require "open-uri"

# Création d'un fichier pour accueillir les résultats

fichier = "AssNat_URLs_40e_legis.txt"

f = File.open(fichier, "w")
f.close

=begin
Boucle pour puiser dans sept documents html préalablement glanés
et qui reproduisent les résultats d'une recherche pour tous les
travaux de la 40e législature.
La recherche donnait un peu plus de 600 résultats (627).
J'ai demandé un affichage de 100 résultats par page (le maximum)
et j'ai créé un document html pour chacune de ces pages.
Chaque document a pour nom "assnat0x.html" où x est un chiffre
de 1 à 7.
=end

for n in 1..7 do

	url1 = "assnat0"
	url2 = ".html"

	url = url1 + n.to_s + url2
	puts url # vérification pendant que le script roule.

# Utilisation de la bibliothèque Nokogiri pour extraire les
# quelque 700 URLs des débats de la 40e législature.

	j = Nokogiri::HTML(open(url))

	urlTemp = []

# Utilisation de la méthode CSS pour aller chercher les hyperliens
# qui se trouvent toujours dans un <td> contenant la même classe.

	page = j.css("td.colonneDate a").map {|lien| lien["href"]}

# Écriture des urls trouvées dans un fichier texte,
# en ajoutant "http://www.assnat.qc.ca".

	f = File.open(fichier, "a")
	page.each do |pp|
		urlTemp.push("http://www.assnat.qc.ca" + pp)
	end

	f.puts urlTemp
	f.close

end

# Réouverture du fichier texte pour aller y lire les urls une à une.

urlFin = File.open(fichier, "r").readlines.each do |ligne|
	ligne
end

# On met le tout en ordre alphabétique.
# Il faut faire cet ordre à la toute fin, à l'extérieur de la boucle,
# une fois qu'on a écrémé nos sept fichiers html.

urlFin.sort!

# Réécriture des urls dans le fichier texte, mais en ordre.

f = File.open(fichier, "w")

f.puts urlFin
f.close
