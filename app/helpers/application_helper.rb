module ApplicationHelper
	def full_title(page_title)
		base_title = "Connectify"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def cities
		@city_name = Array["Karlsruhe",#Auch immer in HOME.html.erb  UND SHOW>HTML USER bei Hombase Frage Validation anpassen!!!
							"Konstanz",
							"Munich",
							"Stuttgart",
							"Singen"

					] 
	end

	def cities_trans
		@cities = Array.new()
		for city in cities
			@cities.push(t('home.micropost.'+city))
		end
		@cities
	end

	def citylist
		@city = Array.new()
		for city in cities

		@city.push([t('home.micropost.'+city), city])
		
			end
			@city
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

	def sports
		Array["beachvolleyball",
			"dancing",
			"sailing",
			"badminton",
			"basketball",
			"mountainbiking",
			"wheelchairsport",
			"trailrunning",
			"ultimatefrisbee",
			"zumba",
			"archery",
			"chess",
			"parkour",
			"featherball",
			"tablesoccer",
			"tabletennis",
			"biking",
			"bouldering",
			"hiking",
			"climbing",
			"nordicwalking",
			"skiing",
			"slacklining",
			"soccer",
			"surfing",
			"swimming",
			"windsurfing",
			"workout",
			"yoga",
			"jogging",
			"speedbike",
			"pilates",
			"rowing"

		]
	end


	def sportlist
		@sports = Array.new()
		for sport in sports
			@sports.push([t('home.micropost.'+sport), sport])
		end
		@sports
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
