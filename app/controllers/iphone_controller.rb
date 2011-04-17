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
    dataVector = Links.all
    i=0
    for data in dataVector do
	i += 1
	@xml += '<article>'
	@xml += '<title>'
	@xml += data['name']
	@xml += '</title>'
	@xml += '<date>'
	@xml += data['created_at']
	@xml += '</date>'
	@xml += '<link>'
	@xml += data['link']
	@xml += '</link>'
	@xml += '<srpoints>'
	@xml += '1592'
	@xml += '</srpoints>'
  	@xml += '</article>'
	if i == 20 then
	  break
	end
    end
    @xml += endroot
    puts "XML=" + @xml
    respond_to do |format|
    	format.html
	format.xml { render :xml => @xml }
    end
  end
end
