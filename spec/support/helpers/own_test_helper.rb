module OwnTestHelper

	def sign_in(credentials)
		visit signin_path
		fill_in('username', with:credentials[:username])
    	fill_in('password', with:credentials[:password])
    	click_button('Log in')
    end

    def create_rating(information)
    	visit new_rating_path
  		select(information[:beer], from:'rating[beer_id]')
  		fill_in('rating[score]', with:information[:score])
  		click_button "Create Rating"
    end
end