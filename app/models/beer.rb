class Beer < ActiveRecord::Base
	include RatingAverage
	validates :style, presence:true
	validates :name, length: {minimum: 3}
	belongs_to :brewery
	has_many :ratings, :dependent => :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user
	
	def to_s
		"#{name}, (Brewery): #{brewery.name}"
	end

end
