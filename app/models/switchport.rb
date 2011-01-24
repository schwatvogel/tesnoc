class Switchport < ActiveRecord::Base
	validates_presence_of :name
		belongs_to :switch
		belongs_to :user



end
