class Mindpost < ActiveRecord::Base

	belongs_to :user
	belongs_to :micropost
	
	validates :user, presence: true
 	validates :micropost, presence_: true
end