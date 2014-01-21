class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratings.inject(0) {|result,rating| result + rating.score}/ratings.count
    #ratings.average(:score).to_i
  end
end
