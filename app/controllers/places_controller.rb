class PlacesController < ApplicationController
  before_action :set_place, only: [:show]
  def index
  end

  def search
  	@places = BeermappingApi.places_in(params[:city])
    session[:city] = params[:city]
  	if @places.empty?
  		redirect_to places_path, notice: "No locations in #{params[:city]}"
  	else
  		render :index
    end
  end

  def show

  end

  def set_place
    @place = BeermappingApi.place_by_id(params[:id], session[:city])
  end
 
end