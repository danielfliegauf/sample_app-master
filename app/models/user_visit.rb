class UserVisit < ActiveRecord::Base
  attr_accessible :visited_at, :visitor_id

  belongs_to :user
  belongs_to :visitor, :foreign_key => 'visitor_id', :class_name => 'User'
end
