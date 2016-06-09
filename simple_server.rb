require "socket"
require "json"

server = TCPServer.open(2000)
loop {
	client=server.accept
	puts"accepted"
	request=client.recv(1000)
	puts "megkaptam"
	headers,body = request.split("\r\n\r\n")
	puts request
	puts headers
	puts body
	type,path,version = headers.split(" ", 4)
	if File.exists?(path)
		if type == "GET"
			filedata=File.read(path)
			client.puts"#{version} 200 OK\r\n" + Time.now.ctime + "\r\n Content-Type: text/html \r\n Content-Length: #{filedata.size}\r\n\r\n"
			client.puts filedata
		else
			params = {}; params = JSON.parse(body)
			file= File.open("thanks.html", "r")
			text=file.read
			replacement=""
			params["viking"].each do |key, value|
					replacement+="<li>#{key}: #{value}</li>"
				end
			text.gsub!("<%= yield %>", replacement)
			client.puts text
		end
	else 
		client.puts"#{version} 404 ERROR\r\n"
	end
	client.puts(Time.now.ctime)
	client.puts "Closing connection, cya!"
	client.close
}