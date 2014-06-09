#!/usr/bin/env ruby

partis = ["PQ", "PLQ", "CAQ", "QS"]

# variable pour ne requérir que les mots de plus de 3 caractères
nbMots = (3..10).to_a

# boucle pour aller chercher des fichiers prélablement confectionnés
# (qui contiennent ce qui a été dit par les députés de chacun des partis)
# et pour écrire des listes de mots par nb de caractères et par parti 
partis.each do |parti|
	fichier = "wordcloud-assnat-" + parti + ".txt"
	nbMots.each do |nb|
		fichier2 = "wordcloud-assnat-liste-mots-" + parti + "-" + nb.to_s + ".txt"
		contenu = File.open(fichier, "r").read

		# test utile aux fins de débogage = File.open("test.txt", "w")

		# cette boucle met le texte en minuscules, puis le nettoie
		# enfin, elle écrit le texte nettoyé dans un fichier distinct

		contenu = contenu.gsub(/[«»".!?,;:]/,'').downcase
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(/\s--\s/,' ')
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(/\s{2,}/,' ')
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub("\n"," ")
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(" ","\n")
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(/^.{1,#{nb-1}}$/,"")
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(/^.{#{nb+1},}$/,"")
		# # test.puts contenu
		# # test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub("\n"," ")
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(/\s{2,}/," ")
		# test.puts contenu
		# test.puts "++++++++++++++++++++++++++"
		contenu = contenu.gsub(" ","\n")
		# test.puts contenu	

		f = File.open(fichier2, "w")
		f.puts contenu

	end

	# dernière passe pour créer un fichier de la liste des mots de plus de 10 caractères

	fichier3 = "wordcloud-assnat-liste-mots-" + parti + "-11_et_plus.txt"
	puts fichier3
	
	contenu = File.open(fichier, "r").read

	# nettoyage de la liste des mots de 10 caractères ou plus
	# il y a sans doute moyen de simplifier mon script
	# et de faire en sorte que cette dernière passe
	# soit incluse dans la boucle, mais je n'ai pas réussi
	
	contenu = contenu.gsub(/[«»".!?,;:]/,'').downcase
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(/\s--\s/,' ')
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(/\s{2,}/,' ')
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub("\n"," ")
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(" ","\n")
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(/^.{1,10}$/,"")
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	# # contenu = contenu.gsub(/^.{#{nb+1},}$/,"")
	# # test.puts contenu
	# # test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub("\n"," ")
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(/\s{2,}/," ")
	# test.puts contenu
	# test.puts "++++++++++++++++++++++++++"
	contenu = contenu.gsub(" ","\n")
	# test.puts contenu	

	f = File.open(fichier3, "w")
	f.puts contenu

end
