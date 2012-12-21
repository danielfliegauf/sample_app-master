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
		@city = Array[[t('home.micropost.'+'Karlsruhe'), "Karlsruhe"], [t('home.micropost.'+'Munich'), "Munich"], [t('home.micropost.'+'Konstanz'), "Konstanz"], [t('home.micropost.'+'Berlin'), "Berlin"]]

	end

	def citylist2
      @city = Micropost.find_by_sql('SELECT DISTINCT place FROM microposts')
      @place = Array.new(@city.length)

      for city in @city
      	unless city == nil || city == "" || city == "Karlsruhe"
      		@place.push([t('home.micropost.'+city.place), city.place])
      		@place.shift
      	end	
      end
      
      @place

	end

	def sportlist
		Array[[t('home.micropost.beachvolleyball'), "beachvolleyball"], [t('home.micropost.biking'), "biking"], [t('home.micropost.bouldering'), "bouldering"], [t('home.micropost.climbing'), "climbing"], [t('home.micropost.hiking'), "hiking"], [t('home.micropost.jogging'), "jogging"], [t('home.micropost.martialarts'), "martialarts"], [t('home.micropost.nordicwalking'), "nordicwalking"], [t('home.micropost.pilates'), "pilates"], [t('home.micropost.skiing'), "skiing"], [t('home.micropost.slacklining'), "slacklining"], [t('home.micropost.soccer'), "soccer"], [t('home.micropost.surfing'), "surfing"], [t('home.micropost.swimming'), "swimming"], [t('home.micropost.volleyball'), "volleyball"], [t('home.micropost.windsurfing'), "windsurfing"], [t('home.micropost.workout'), "workout"], [t('home.micropost.yoga'), "yoga"], [t('home.micropost.other'), "other"]]
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
