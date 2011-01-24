class Switch < ActiveRecord::Base
	validates_presence_of :name, :description , :ip
	has_many :switchports
end
