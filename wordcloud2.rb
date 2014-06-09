#!/usr/bin/env ruby

# require "csv"

partis = ["QS", "CAQ", "PQ", "PLQ"]

partis.each do |parti|
	fichier = "wordcloud-assnat-" + parti + ".txt"

	fichier3 = "wordcloud-assnat-liste-mots-" + parti + ".txt"
	puts fichier3
	
	contenu = File.open(fichier, "r").read
	
	contenu = contenu.gsub(/[«»",.;:!?()]/,'').downcase
	contenu = contenu.gsub('applaudissements','')
	contenu = contenu.gsub(/\s.{1,2}'/," ")
	contenu = contenu.gsub("\[",'')
	contenu = contenu.gsub("\]",'')
	contenu = contenu.gsub(/[[:space:]]+--[[:space:]]+/,' ')
	contenu = contenu.gsub(/\s{2,}/,' ')
	contenu = contenu.gsub("\n"," ")
	contenu = contenu.gsub(" ","\n")
	contenu = contenu.gsub(/^.{,2}$/,"")
	contenu = contenu.gsub("\n"," ")
	contenu = contenu.gsub(/\s{2,}/," ")
	contenu = contenu.gsub(" ","\n")

	f = File.open(fichier3, "w")
	f.puts contenu

end
