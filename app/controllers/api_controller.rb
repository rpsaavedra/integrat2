class ApiController < ApplicationController

  def index
  	tag= "melipillazo"
  	token="2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	cantidad = getCantidad(tag,token)
  	response = { :metadata =>  { :cantidad => cantidad}}
  	render :json => response

  end

  def buscar

  	tag= params[:tag].to_s
  	token= params[:access_token].to_s


  	totales JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag +"?access_token="+token).to_s, :symbolize_names => true)

  end


 def getCantidad(tag,token)
 	totales =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+"?access_token="+token).to_s, :symbolize_names => true)
 	return totales[:data][:media_count]
 end

end
