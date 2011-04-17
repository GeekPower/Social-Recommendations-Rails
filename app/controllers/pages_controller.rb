require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
class PagesController < ApplicationController
#	before_filter :authenticate_user!
	def index
		#@my_movie = Movie.where("titlu = ?", "Lord of")[0]
#		id = get_logged_in_user()

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
	 	token = "2227470867|2.oP_P8ogelJn8_g4aBdTe0Q__.3600.1303027200.0-100001135457346|BKDwdGyPHLAmPq0-I0GLbMJ36Gk"
   		url = "https://graph.facebook.com/#{id}/friends?access_token=#{URI.encode(token)}"
		open(URI.encode(url)){ |f|
		  f.each_line {|line|
	  	    parsed = JSON.parse(line)
	  	    parsed['data'].each{|friend|
	    	      @my_friends = @my_friends << friend['name'] << "\t" << friend['id'] << "\n"
#	    	      friend_url = "https://graph.facebook.com/#{friend['id']}/likes?access_token=#{URI.encode(token)}"
#	    	      open(URI.encode(friend_url)){|fr_url|
#	      		fr_url.each_line{|l|
#                	  parsed_l = JSON.parse(l)
#			  parsed_l['data'].each {|like|
#		  	   @friends_likes << friend['name'] << "\t" << friend['id'] << "\t" << like['name'] << "\t" << like['id']	
#                          }
#	                }
#	              }
	           }
	         }
              }

	end
end
