class Interest < ActiveRecord::Base
  attr_accessible :hobby, :homebase
  belongs_to :user
end
