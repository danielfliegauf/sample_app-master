class Comment < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :user
  attr_accessible :body, :read
end
