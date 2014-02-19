class Beer < ActiveRecord::Base
	include RatingAverage
	validates :style, presence:true
	validates :name, length: {minimum: 3}
	belongs_to :brewery
	has_many :ratings, :dependent => :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user
	belongs_to :style
	
	def to_s
		"#{name}, (Brewery): #{brewery.name}"
	end

	def self.top(n)
		sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    	sorted_by_rating_in_desc_order.take(n)
	end

end
