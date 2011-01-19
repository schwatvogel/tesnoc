# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def logo
	        image_tag("logo1.png", :alt => "Sample App", :class => "round")

	end
	def gravatar(user,size=80)
		require 'digest'
                image_tag("http://www.gravatar.com/avatar.php?gravatar_id=#{Digest::MD5::hexdigest(user.email)}&s=#{size}&d=mm", :alt => 'Avatar', :class => 'avatar')
	end
	

	def title
		base_title = "Sergels RoR TestApp"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{h(@title)}"
		end
	end

end
