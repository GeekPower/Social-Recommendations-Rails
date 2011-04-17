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
		@friends_likes = []
		link = ""

		id = 'me'
	 	#token = "2227470867|2.sHXg2t7r7fII2_wNKrJIYw__.3600.1303034400.0-100001135457346|fK_BWPMbFMFaF6t08N2PxCbNG_E"
		if session["access_token"]
			token = session["access_token"]
		else
			redirect_to :root
		end

   		url = "https://graph.facebook.com/#{id}/friends?access_token=#{URI.encode(token)}&limit=10"

		puts "A intrat in controller"

		open(URI.encode(url)) do |f|
		  f.each_line do |line|
	  	    parsed = JSON.parse(line)
	  	    parsed['data'].each do |friend|
	    	      @my_friends = @my_friends + friend['name'] + "," + friend['id'] + "|"
		      #filter = "-1 week"
		      filter = ""
	    	      friend_url = "https://graph.facebook.com/#{friend['id']}/likes?access_token=#{URI.encode(token)}"
		      puts "Friend url=" + friend_url
	    	      open(URI.encode(friend_url)){|fr_url|
	      		fr_url.each_line{|l|
                	  parsed_l = JSON.parse(l)
			  parsed_l['data'].each {|like|
			   if like['category'] == 'Website'
				site_url = "https://graph.facebook.com/#{URI.encode(like['id'])}/"
				open(URI.encode(site_url)) {|s_url|
				  s_url.each_line{ |s|
				    puts s
				    parsed_s = JSON.parse(s)
				    link = parsed_s['link']
				  }
				}
		  	   	@friends_likes = @friends_likes +  friend['name'] + "," + friend['id'] + "," + like['name'] + "," + like['id'] + "," +  link + "|"
				puts "Link" + link
			   end
                         }
	                }
	              }
	           end
	         end
              end

	      puts "Friends likes:"
	      puts @friends_likes
	end
end
