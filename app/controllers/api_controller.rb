class ApiController < ApplicationController

  def index
  	tag= "snow"
  	token="2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	cantidad = getCantidad(tag,token)

  	datos= getPost(tag,token)
  	
  	if(datos.count == 0)
  		response = { :metadata =>  { :cantidad => cantidad}, :posts =>  []  }
  		render :json => response
  	end

  	persona = getPostx(datos,0)
  	nuevo = Array.new
  	nuevo.push(persona)
	

  	largo = datos.count
  	if(cantidad>=largo)
  		for i in 1..(largo-1)
  			persona = getPostx(datos,i)
  			nuevo.push(persona)
  		end
  	end
  	if (cantidad < largo)
  		for i in 1..(cantidad-1)
  			persona = getPostx(datos,i)
  			nuevo.push(persona)
  		end
  	end
  	
  	response = { :metadata =>  { :cantidad => cantidad}, :posts =>  nuevo  }
  	
  	render :json => response

  end

  def buscar

  	tag= params[:tag].to_s
  	token= params[:access_token].to_s


  	cantidad = getCantidad(tag,token)

  	datos= getPost(tag,token)
  	
  	if(datos.count == 0)
  		response = { :metadata =>  { :cantidad => cantidad}, :posts =>  []  }
  		render :json => response
  	end

  	persona = getPostx(datos,0)
  	nuevo = Array.new
  	nuevo.push(persona)
	

  	largo = datos.count
  	if(cantidad>=largo)
  		for i in 1..(largo-1)
  			persona = getPostx(datos,i)
  			nuevo.push(persona)
  		end
  	end
  	if (cantidad < largo)
  		for i in 1..(cantidad-1)
  			persona = getPostx(datos,i)
  			nuevo.push(persona)
  		end
  	end
  	
  	response = { :metadata =>  { :cantidad => cantidad}, :posts =>  nuevo  }
  	
  	render :json => response
  end


 def getCantidad(tag,token)
 	totales =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+"?access_token="+token).to_s, :symbolize_names => true)
 	return totales[:data][:media_count]
 end


 def getPost(tag, token)
 	post =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+ "/media/recent?access_token="+ token).to_s, :symbolize_names => true)
 	return post[:data]
 end


 def getPostx(data,numero)
 	tags = data[numero][:tags]
 	username = data[numero][:caption][:from][:username]
 	likes =data[numero][:likes][:count]
 	type = data[numero][:type]
 	if(type == "image")
 		url = data[numero][:images][:standard_resolution][:url]

 	end

 	if(type == "video")
 		url = data[numero][:videos][:standard_resolution][:url]
 	end
 	caption = data[numero][:caption][:text]

 	return  {:tags =>tags , :username =>username, :likes => likes, :type=>type, :url => url, :caption => caption }
 	 
 end

end
