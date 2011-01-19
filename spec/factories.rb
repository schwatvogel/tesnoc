
Factory.define :user do |user|
	user.name 			"test user"
	user.email 			"wurst@brot.de"
	user.password			"wurstbrot"
	user.password_confirmation 	"wurstbrot"
end

Factory.define :micropost do |micropost|
	micropost.content "Fooo Baar"
	micropost.association :user
end
