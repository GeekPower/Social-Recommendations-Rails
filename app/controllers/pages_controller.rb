require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
class PagesController < ApplicationController
	def index
		puts "Session" + session.to_s

		@likes = Links.all

		@user_logged_in = false
		if session["access_token"]
			@user_logged_in = true
		end
	end


	def friends
		@my_friends = ""
		@friends_likes = ""
		link = ""

		id = 'me'
		if session["access_token"]
			token = session["access_token"]
		else
			redirect_to :root
		end

   		url = "https://graph.facebook.com/#{id}/friends?access_token=#{URI.encode(token)}"

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
			   website = like["website"]
			   if like["company_overview"]
				   description = like["company_overview"]
			   else
			   	   description = "No description"
		           end
			   if like['category'] == 'Website'
				site_url = "https://graph.facebook.com/#{URI.encode(like['id'])}/"
				
				open(URI.encode(site_url)) {|s_url|
				  s_url.each_line{ |s|
				    puts s
				    parsed_s = JSON.parse(s)
				    link = parsed_s['link']
				  }
				}
				new_like = Links.new(:link => link, :name => like['name'], :facebookid => like['id'], :user_name => friend['name'], :user_id => friend['id'], :description => description, :count => 0)
				ll = Links.all
				gasit = 0
				for l in ll
					if l.facebookid == new_like.facebookid
						gasit = 1
						l.count = l.count + 1
						l.save
						break
					end
				end
				if gasit == 0
					new_like.save
				end

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
