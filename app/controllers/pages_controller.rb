require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
class PagesController < ApplicationController
#	before_filter :authenticate_user!
	def index
		#@my_movie = Movie.where("titlu = ?", "Lord of")[0]
#id = get_logged_in_user()
		puts "Session" + session.to_s

		@user_logged_in = false
		if session["access_token"]
			@user_logged_in = true
		end

		#@my_movie.titlu = "Lord of the Rings"
		#@my_movie.link = "http://imbd.com"
		#if @my_movie.save
		#else
		#end
	end
	def friends
		@my_friends = ""
		@friends_likes = ""
		id = 'me'
	 	token = "2227470867|2.sHXg2t7r7fII2_wNKrJIYw__.3600.1303034400.0-100001135457346|fK_BWPMbFMFaF6t08N2PxCbNG_E"
   		url = "https://graph.facebook.com/#{id}/friends?access_token=#{URI.encode(token)}"
		open(URI.encode(url)){ |f|
		  f.each_line {|line|
	  	    parsed = JSON.parse(line)
	  	    parsed['data'].each{|friend|
	    	      @my_friends = @my_friends << friend['name'] << "\t" << friend['id'] << "\n"
		      filter = "-1 week"
	    	      friend_url = "https://graph.facebook.com/#{friend['id']}/likes?since=#{filter}&access_token=#{URI.encode(token)}"
	    	      open(URI.encode(friend_url)){|fr_url|
	      		fr_url.each_line{|l|
                	  parsed_l = JSON.parse(l)
			  parsed_l['data'].each {|like|
			   if like['category'] == 'Website'
		  	   	@friends_likes << friend['name'] << "\t" << friend['id'] << "\t" << like['name'] << "\t" << like['id'] << "\t" << like['category'] << "\n"	
			   end
                         }
	                }
	              }
	           }
	         }
              }

	end
end
