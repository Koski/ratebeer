class Brewery < ActiveRecord::Base

  include RatingAverage

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  def no_future_year
    if year > Time.now.year
      errors.add(:year, "- no futuristic breweries!")
    end
  end

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    only_integer: true }
  validate :no_future_year


  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

end
