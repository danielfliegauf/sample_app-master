module UsersHelper

	#Returns the Gravatar for the given User
	def gravatar_for(user, options = { size: 50 })
   		gravatar_id = user.uid
  		size = options[:size]
  		gravatar_url = "https://graph.facebook.com/#{gravatar_id}/picture?type=square"
  		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
