# == Schema Information
# Schema version: 20110112093053
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user
	default_scope :order => "created_at DESC"
	validates_presence_of :content, :user_id
	validates_length_of :content, :maximum=> 140
end
