class IphoneController < ApplicationController
  def iphoneget
    category = params[:category]
    data = params[:data]
    user = params[:user]
    header = '<?xml version="1.0"?>'
    root = '<articles>'
    endroot = '</articles>'
    @xml = header + root
    puts @xml
    for i in 1..5 do
	@xml += '<article>'
	@xml += '<title>'
	@xml += 'Title of article' # Get title from SQL
	@xml += '</title>'
	@xml += '<content>'
	@xml += 'Content of article' # Get article from SQL
	@xml += '</content>'
	@xml += '<date>'
	@xml += 'Date of article' # Get date from SQL
	@xml += '</date>'
  	@xml += '</article>'
    end
    @xml += endroot
    puts "XML=" + @xml
    respond_to do |format|
    	format.html
	format.xml { render :xml => @xml }
    end
  end
end
