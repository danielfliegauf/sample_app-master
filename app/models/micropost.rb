class Micropost < ActiveRecord::Base
  attr_accessible :content, :hobby, :place, :datetime, :weekly, :weekday, :status, :latlng, :level, :country, :micropost_id, :zeit #time_for TYPO!!!
  belongs_to :user
  has_many :mindposts
  has_many :comments, :dependent => :destroy

  validates :user_id, presence: true
  validates :hobby, presence: true
  # validates :latlng, presence: true
  validates :country, presence: true
  # validates :content, presence: true, length: { maximum: 1340 }
  # validates :level, presence: true
  validates :place, presence: true

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
  	followed_user_ids = user.followed_user_ids
    mindpostings = user.mindposts.collect { |i| i.micropost_id}
    where("user_id IN (?) OR user_id = ? OR id IN (?)", followed_user_ids, user, mindpostings)
  end

  def self.search(place)
    # if hobby != '' && place != ''
    #   find(:all, :order => 'id DESC', :conditions => ['hobby LIKE ? AND place LIKE ? AND datetime >= ?', "%#{hobby}%", "%#{place}%", Time.now])
    #   #find(:all, :order => 'hobby ASC')
    #   #find_by_sql('SELECT * FROM microposts WHERE hobby = "klettern"')
    # elsif hobby == '' && place != ''
    #   find(:all, :order => 'id DESC', :conditions => ['place LIKE ? AND datetime >= ?', "%#{place}%", Time.now])
    # else
    #   find(:all)
    # end

    if place != ''
      find(:all, :order => 'id DESC', :conditions => ['place LIKE ? AND datetime >= ?', "%#{place}%", Time.now])
    else
      find(:all)
    end
  end


end
