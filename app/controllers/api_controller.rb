class ApiController < ApplicationController
	skip_before_filter  :verify_authenticity_token

  def index
  
  	tag= "melipillazo"
  	token="2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  	cantidad = getCantidad(tag,token)

  	datos= getPost(tag,token)
  	
  
  	persona = getPostx(datos,0)
  	nuevo = Array.new
  	nuevo.push(persona)
	

  	largo = datos.count
  		for i in 1..(largo-1)
  			persona = getPostx(datos,i)
  			nuevo.push(persona)
  		end
  	
  	
  	
  	response = { :metadata =>  { :cantidad => cantidad}, :posts =>  nuevo  }
  	
  	render :json => response

  end

  def buscar
    tag= params[:tag].to_s
    token= params[:access_token].to_s

  
  
  if token.nil? || tag.nil?
      resp = {:error => 400}.to_json 
      
      render :json => resp, :status => :bad_request

    else
 
  	begin
    	

    	cantidad = getCantidad(tag,token)

    	datos= getPost(tag,token)
    	
    	if(datos.count == 0)
    		response = { :metadata =>  { :total => cantidad}, :posts =>  []  }
    		render :json => response
        return
    	end

    	persona = getPostx(datos,0)
    	nuevo = Array.new
    	nuevo.push(persona)
  	

    	largo = datos.count
    	if(cantidad>=largo)
    		for i in 1..(largo-1)
         # puts "antes del getPostx"
    			persona = getPostx(datos,i)
          #puts "luego del get, antes de pushear"
    			nuevo.push(persona)
          #puts "entre a el largo :P"
    		end
    	end
    	if (cantidad < largo)
    		for i in 1..(cantidad-1)
    			persona = getPostx(datos,i)
    			nuevo.push(persona)
         # puts "he entrado a cantidad"
    		end
    	end
    	
    	response = { :metadata =>  { :total => cantidad}, :posts =>  nuevo , :version => $version }
    	
    	render :json => response

  	rescue => ex
        respuesta_json = {:error => 400}.to_json
        render :json => respuesta_json, :status => :bad_request
    end

  end
  end


 def getCantidad(tag,token)
 	totales =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+"?access_token="+token).to_s, :symbolize_names => true)
 	return totales[:data][:media_count]
 end


 def getPost(tag, token)
 	post =JSON.parse(HTTP.headers(:"Content-Type" => "application/json").get("https://api.instagram.com/v1/tags/"+ tag+ "/media/recent?access_token="+ token).to_s, :symbolize_names => true)
 #	puts post[:data]
  return post[:data]
 end


 def getPostx(data,numero)
 	tags = data[numero][:tags]
#  puts "1. antes de user name xxxx"
 	username = data[numero][:user][:username]
 # puts "2. antes de ver los likes"
 	likes =data[numero][:likes][:count]
 # puts "3. antes de hacer el type"
 	type = data[numero][:type]
 	if(type == "image")
 #   puts "4. imagen"
 		url = data[numero][:images][:standard_resolution][:url]

 	end

 	if(type == "video")
  #  puts "4. tipo vdeo"
 		url = data[numero][:videos][:standard_resolution][:url]
 	end
 

  if(data[numero][:caption].nil?)
    caption = ""
  else
 	  caption = data[numero][:caption][:text]
  end


 	return  {:tags =>tags , :username =>username, :likes => likes, :type=>type, :url => url, :caption => caption }
 	 
 end

end
