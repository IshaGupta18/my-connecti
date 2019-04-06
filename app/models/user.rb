class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2,:facebook]
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships



  def self.from_omniauth(data) #data given by google, entire class, check poori class mein se whether this obj exists find and create User.from_omniauth,data is a has

  	user=User.find_by(email: data.email)

  	if user.blank?
  		user=User.create(
  				email: data.email,
  				password: SecureRandom.uuid

  			)
  	end

  	return user




  end

  def set_auth_token
      self.auth_token = SecureRandom.uuid
      self.save
  end
end
