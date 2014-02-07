class User < ActiveRecord::Base
	include RatingAverage

	def favorite_beer
		return nil if ratings.empty?
		ratings.order(score: :desc).limit(1).first.beer
    end
    def favorite_style
    	return nil if ratings.empty?
    	styles = ratings.map{|r| r.beer.style}.uniq
    	largest = -1
    	retStyle = nil
    	styles.each do |style|
    		styleRatings = ratings.select{|r| r.beer.style == style}
    		sum = styleRatings.inject(0.0){|result, rating| result+rating.score }
    		average = sum/styleRatings.count
    		if average > largest
    			largest = average
    			retStyle = style
    		end
    	end

    	return retStyle
    end
	
	def favorite_brewery
		return nil if ratings.empty?
		brews = ratings.map{|r| r.beer.brewery}.uniq
		largest = -1
		retBrew = nil
		brews.each do |brew|
			brewRatings = ratings.select{|r| r.beer.brewery == brew}
			sum = brewRatings.inject(0.0){|result, rating| result+rating.score}
			average = sum / brewRatings.count
			if average > largest
				largest = average
				retBrew = brew
			end
		end
		return retBrew.name
	end	

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
