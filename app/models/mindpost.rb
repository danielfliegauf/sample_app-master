class Mindpost < ActiveRecord::Base

	belongs_to :user
	belongs_to :micropost

	attr_accessible :micropost_id, :user_id #nötig?
	validates :user, presence: true
 	validates :micropost, presence_: true
end