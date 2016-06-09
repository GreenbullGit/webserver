require "socket"

hostname= "localhost"
port= 2000

s = TCPSocket.open(hostname, port)

s.write "GET index.html HTTP/1.0\r\n\r\n"
puts "elkuldtem"
while line = s.gets
	puts line.chop
end
s.close