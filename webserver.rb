require 'socket'

server = TCPServer.new('0.0.0.0', 80)
#collecting ip address.
ipaddress_infos = Socket.ip_address_list.detect(&:ipv4_private?)&.ip_address

loop do
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  method, path, version = request.lines[0].split

#adding extra lines to print the ip address details.
  if path == "/healthcheck"
    response = "OK from #{ipaddress_infos}!\n"
  else
    response = "Well, hello there from #{ipaddress_infos}!\n"
  end

#additional responses to test via ansible-playbooks
  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/plain\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n"
  socket.print "\r\n"
  socket.print response
  socket.close
end
