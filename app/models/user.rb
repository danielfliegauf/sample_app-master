class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_token, :last_active, :group#, :password, :password_confirmation
  has_many :comments, dependent: :destroy
  has_many :mindposts, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower #source can be omitted! rails schaut automatisch nach dem Singlar_id von followers
  
  has_many :invitations, foreign_key: "inviter_id", dependent: :destroy
  has_many :invited_users, through: :invitations, source: :invited
  has_many :reverse_invitations, foreign_key: "invited_id", class_name: "Invitation", dependent: :destroy
  has_many :inviters, through: :reverse_invitations, source: :inviter

  has_many :interests, dependent: :destroy

  has_many :user_visits, dependent: :destroy
  has_many :visitors, :through => :user_visits, :source => :visitor
  # has_secure_password

  # before_save { |user| user.email = email.downcase }
  # before_save :create_remember_token

  # validates :name, presence: true, length: { maximum: 50 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # validates :password, presence: true, length: { minimum: 6 }

  # validates :password_confirmation, presence: true

  def self.searchplace(place)
    if place != '' #place ist immer != '' auch wenn man zuerst die seite aufruft :/
      find(:all)# find(:all, :order => 'id DESC', :conditions => ['homebase LIKE ?', "%#{place}%",])
    else
      find(:all)
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      
      
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.group = false
      # if user.uid.to_s == "1423616689"
      #   user.admin = true
      # end
      # user.update_attributes(:oauth_token => auth.credentials.token)
      
      if (!where(auth.slice(:provider, :uid)).first)
        #send welcome email BEFORE USER SAFE!
        RegistrationMailer.welcome_email(user).deliver
      end

      user.save!

      # unless where(auth.slice(:provider, :uid)).first
      #  UserMailer.welcome_email(user).deliver  
      # end
    end
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id) #auch mit self. vorne möglich!
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def invite!(other_user, micropost)
    invitations.create!(invited_id: other_user.id, status: 1, micropost: micropost)
  end

  def uninvite!(other_user)
    invitations.find_by_invited_id(other_user.id).destroy #where mit micropost muss noch hin
  end

  def invited?(other_user)
    invitations.find_by_invited_id(other_user)
  end

  def interested!(interest, homebase)
      interests.create!(hobby: interest, homebase: homebase)
  end

  def not_interested!(interest)
      interests.find_by_hobby(interest).destroy
  end


  def remembering?(micropost)
    mindposts.find_by_micropost_id(micropost)
  end


  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
