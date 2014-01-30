class User < ActiveRecord::Base

	include RatingAverage
	has_many :ratings, :dependent => :destroy
	has_many :beers, through: :ratings
	has_many :memberships, :dependent => :destroy
	has_many :beer_clubs, through: :memberships

	has_secure_password

	validates :username,
		 uniqueness: true, 
		 length:
		 	{minimum: 3,
			 maximum: 15}
	
	#validates :password, presence: { on: :create }, length: { minimum: 4 }
	validates :password, presence: { on: :create }, format: { with: /\A((?=.*\d)(?=.*[A-Z])).{4,}/}
	#validate :password, length: {minimum: 4}
	#validate :password, format: { with: /^((?=.*\d)(?=.*[A-Z])).{4,}$/, on: :create}
	
end
