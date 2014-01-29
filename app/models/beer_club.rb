class BeerClub < ActiveRecord::Base
	has_many :Memberships
	has_many :users, through: :Memberships

end
