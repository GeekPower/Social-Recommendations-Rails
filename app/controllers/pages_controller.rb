class PagesController < ApplicationController
#	before_filter :authenticate_user!
	def index
		@my_movie = Movie.where("titlu = ?", "Lord of")[0]
		

		#@my_movie.titlu = "Lord of the Rings"
		#@my_movie.link = "http://imbd.com"
		#if @my_movie.save
		#else
		#end
	end
end
