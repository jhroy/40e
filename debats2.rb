#!/usr/bin/env ruby

require "nokogiri"
require "open-uri"
require "csv"

fichier = "AssNat_URLs_40e_legis.txt"
fich2 = "Debats_40e_legis-2.txt"
fichCSV = "Debats_40e_legis-2.csv"

# Création d'un fichier dans lequel le contenu «scrapé» sera consigné.

fich = File.open(fich2, "w")
fich.puts "Réécriture"
fich.close

fich1 = CSV.open(fichCSV, "wb")
fich1.puts ["Date", "Lieu", "Intervenant", "Contenu"]
fich1.close

# Ouverture d'un fichier préalablement «scrapé» qui contient les 627
# URLs différents où sont consignés les débats de la 40e législature.
# Lecture des URLs une à la fois.

url = File.open(fichier, "r").readlines
puts url.size # Écriture du nombre d'URLs dans le terminal, pour vérifier

# Boucle glanant une URL à la fois.

for n in 0..url.size-1 do

	puts n+1
	puts url[n]
	type = ""
	mots = []
	dates = []

	if url[n].start_with?("http://www.assnat.qc.ca/fr/travaux-parlementaires/assemblee-nationale/")
		type = "Débat à l'Assemblée nationale"
	elsif url[n].start_with?("http://www.assnat.qc.ca/fr/travaux-parlementaires/commissions/")
		type = "Commission parlementaire"
	end

	contenu = Nokogiri::HTML(open(url[n]))

# On va chercher uniquement les paragraphes contenant l'attribut align
# de valeur "JUSTIFY", et on leur attribue un numéro séquentiel.

	contenu.xpath('//h2').each do |date|
		dates = dates.push(date.content)
	end
	
	contenu.xpath('//p[@align="JUSTIFY"]').each do |mot|
		mots = mots.push(mot.content)
	end

# Écriture du contenu de chaque paragraphe de débat avec son numéro séquentiel.

	f = File.open(fich2, "a")
	c = CSV.open(fichCSV, "a+")
	f.puts type
	for i in 0..dates.size-1 do
		if dates[i].strip.start_with?("Le lundi", "Le mardi", "Le mercredi", "Le jeudi", "Le vendredi", "Le samedi", "Le dimanche")
			date = dates[i].strip
			f.puts date
		end
	end
	for j in 0..mots.size-1 do
		a = mots[j].index(":").to_i
		if a <= 51
			if mots[j].strip.start_with?("Des voix", "Une voix", "Le Président", "Le Vice-", "La Vice-", "M. ", "Mme ")
				intervenant = mots[j].slice(0..a).strip
				f.puts intervenant
			else
				intervenant = ""
			end
		end
		f.puts mots[j].strip.slice(intervenant.size..-1).strip
		c.puts [date, type, intervenant, mots[j].strip.slice(intervenant.size..-1).strip]
	end
	f.close

	sleep 2 # On donne une petite pause de deux secondes au serveur web de l'Assnat

end
