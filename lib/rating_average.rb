module RatingAverage
  def average_rating
    ratings.average(:score).to_f
  end
end