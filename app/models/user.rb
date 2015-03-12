class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]


mount_uploader :image, ImageUploader
#it validates username
validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } # etc.
 
  attr_accessor :login #for sign in with username

   def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
      else
        where(conditions.to_h).first
      end
    end

    #override method from devise to to user is blocked or not
    def active_for_authentication?
    super && !self.banned
    end
end
