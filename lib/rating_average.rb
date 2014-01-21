module RatingAverage
  def average_rating
    ratings.average(:score).to_i
  end
end