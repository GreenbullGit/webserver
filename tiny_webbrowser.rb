require 'socket'
require "json"                 
hostname = 'localhost'
port = 2000     
path = 'index.html'                 

def whatdo
	puts "GET or POST?"
	whattodo=gets.chomp
	if whattodo=="GET" || whattodo== "POST"
		return whattodo
	else whatdo
	end
end

def regviking
	hash= Hash.new
	puts "what's the vikings name?"
	hash["name"] = gets.chomp
	puts "what's the email?"
	hash["email"] = gets.chomp
	return hash
end

s = TCPSocket.open(hostname, port)
type=whatdo
if type=="POST"
	datahash=Hash.new
	datahash["viking"]=regviking
	body=datahash.to_json
	s.write "POST #{path} HTTP/1.0\r\nFrom: #{datahash["viking"]["email"]}\r\nContent-Length:#{body.size}\r\n\r\n#{body}"
else
	s.write "GET index.html HTTP/1.0\r\n\r\n"
	end

while line = s.gets
	puts line.chop
	end     
#if headers.code == "200"               
#  print body                        
#else                                
#  puts "#{headers.code} #{headers.message}" 
