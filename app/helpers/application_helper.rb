module ApplicationHelper
	def full_title(page_title)
		base_title = "Connectify"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def citylist
		@city = Array[	[t('home.micropost.'+'Karlsruhe'), "Karlsruhe"],
						[t('home.micropost.'+'Hamburg'), "Hamburg"],
						[t('home.micropost.'+'Bremen'), "Bremen"],
						[t('home.micropost.'+'Stuttgart'), "Stuttgart"],
						[t('home.micropost.'+'Nuremberg'), "Nuremberg"],
						[t('home.micropost.'+'Bamberg'), "Bamberg"],
						[t('home.micropost.'+'Regensburg'), "Regensburg"],
						[t('home.micropost.'+'Dresden'), "Dresden"],
						[t('home.micropost.'+'Dortmund'), "Dortmund"],
						[t('home.micropost.'+'Leverkusen'), "Leverkusen"],
						[t('home.micropost.'+'Bonn'), "Bonn"],
						[t('home.micropost.'+'Freiburg'), "Freiburg"],
						[t('home.micropost.'+'Munich'), "Munich"],
						[t('home.micropost.'+'Konstanz'), "Konstanz"],
						[t('home.micropost.'+'Berlin'), "Berlin"],
						[t('home.micropost.'+'Wuerzburg'), "Wuerzburg"],
						[t('home.micropost.'+'Muenster'), "Muenster"],
						[t('home.micropost.'+'Goettingen'), "Goettingen"],
						[t('home.micropost.'+'Cologne'), "Cologne"],
						[t('home.micropost.'+'Duesseldorf'), "Duesseldorf"],
						[t('home.micropost.'+'Mannheim'), "Mannheim"],
						[t('home.micropost.'+'Heidelberg'), "Heidelberg"],
						[t('home.micropost.'+'Freiburg'), "Freiburg"],
						[t('home.micropost.'+'Leipzig'), "Leipzig"],
						[t('home.micropost.'+'Halle'), "Halle"],
						[t('home.micropost.'+'Potsdam'), "Potsdam"],
						[t('home.micropost.'+'Rostock'), "Rostock"],
						[t('home.micropost.'+'Kiel'), "Kiel"],
						[t('home.micropost.'+'Ingolstadt'), "Ingolstadt"],
						[t('home.micropost.'+'Frankfurt'), "Frankfurt"]
				]

	end

	def citylist2
      @city = Micropost.find_by_sql('SELECT DISTINCT place FROM microposts')
      @place = Array.new(@city.length)

      for city in @city
      	unless city == nil || city == ""
      		@place.push([t('home.micropost.'+city.place), city.place])
      		@place.shift
      	end	
      end
      
      @place

	end

	def sportlist
		Array[[t('home.micropost.beachvolleyball'), "beachvolleyball"],
		[t('home.micropost.dancing'), "dancing"],

		[t('home.micropost.sailing'), "sailing"],
		[t('home.micropost.aikido'), "aikido"],
		[t('home.micropost.aquafitness'), "aquafitness"],
		[t('home.micropost.badminton'), "badminton"],
		[t('home.micropost.basketball'), "basketball"],
		[t('home.micropost.boxing'), "boxing"],
		[t('home.micropost.capoeira'), "capoeira"],
		[t('home.micropost.fencing'), "fencing"],
		[t('home.micropost.hockey'), "hockey"],
		[t('home.micropost.futsal'), "futsal"],
		[t('home.micropost.handball'), "handball"],
		[t('home.micropost.jujutsu'), "jujutsu"],
		[t('home.micropost.judo'), "judo"],
		[t('home.micropost.karate'), "karate"],
		[t('home.micropost.mountainbiking'), "mountainbiking"],
		[t('home.micropost.ninjutsu'), "ninjutsu"],
		[t('home.micropost.wheelchairsport'), "wheelchairsport"],
		[t('home.micropost.rugby'), "rugby"],
		[t('home.micropost.taekwondo'), "taekwondo"],
		[t('home.micropost.thaebo'), "thaebo"],
		[t('home.micropost.trailrunning'), "trailrunning"],
		[t('home.micropost.ultimatefrisbee'), "ultimatefrisbee"],
		[t('home.micropost.wildlifetrekking'), "wildlifetrekking"],
		[t('home.micropost.zumba'), "zumba"],
		[t('home.micropost.gymnastics'), "gymnastics"],
		[t('home.micropost.archery'), "archery"],
		[t('home.micropost.chess'), "chess"],
		[t('home.micropost.parkour'), "parkour"],
		[t('home.micropost.featherball'), "featherball"],
		[t('home.micropost.tablesoccer'), "tablesoccer"],
		[t('home.micropost.tabletennis'), "tabletennis"],
		[t('home.micropost.biking'), "biking"], 
		[t('home.micropost.bouldering'), "bouldering"],
		[t('home.micropost.climbing'), "climbing"],
		[t('home.micropost.hiking'), "hiking"],
		[t('home.micropost.jogging'), "jogging"],
		[t('home.micropost.martialarts'), "martialarts"],
		[t('home.micropost.nordicwalking'), "nordicwalking"],
		[t('home.micropost.pilates'), "pilates"],
		[t('home.micropost.skiing'), "skiing"],
		[t('home.micropost.slacklining'), "slacklining"],
		[t('home.micropost.soccer'), "soccer"],
		[t('home.micropost.surfing'), "surfing"],
		[t('home.micropost.swimming'), "swimming"],
		[t('home.micropost.volleyball'), "volleyball"],
		[t('home.micropost.windsurfing'), "windsurfing"],
		[t('home.micropost.workout'), "workout"],
		[t('home.micropost.yoga'), "yoga"],
		[t('home.micropost.other'), "other"]]
	end

	#helps to decide whether the hobby takes place from or in a City
	def infrom(hobby)
		if hobby == 'hiking' || hobby == 'skiing' || hobby == 'climbing' || hobby == 'bouldering'
			@ab = t("home.micropost.from")
		else
			@ab = "in"
		end	
	end

end
