class ApiController < ApplicationController

  def index
  	tag= "melipillazo"
  	token="2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	totales =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+"?access_token="+token).to_s, :symbolize_names => true)

  	response = { :stock => totales[:data][:media_count]}
  	render :json => response
  end

  def buscar

  	tag= params[:tag]
  	token= params[:access_token]


  	totales JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+"?access_token="+token).to_s, :symbolize_names => true)

  end

end
