class Invitation < ActiveRecord::Base
  attr_accessible :invited_id, :inviter_id, :status, :micropost

  belongs_to :inviter, class_name: "User"
  belongs_to :invited, class_name: "User"
  

  validates :inviter_id, presence: true
  validates :invited_id, presence: true
  validates :micropost, presence: true
end
