import strutils
import std/[net, nativesockets]

var 
  message: string = "GET / HTTP/1.1"
  serverName: string = "google.com"
  res: string = ""


let socket = newSocket()
let ctx = newContext()
wrapSocket(ctx, socket)

echo "Created Socket!!!"

echo "Start Connection!!!"
socket.connect(serverName, Port(443))

message.add "\r\n"
message.add "Host: google.com" & "\r\n"
message.add "Connection: Keep-Alive" & "\r\n"
message.add "Content-Length: 0" & "\r\n"
message.add "\r\n"
socket.send(message)

var line: string = ""
while true:
  echo "."
  line = socket.recvLine()
  res.add line
  if line.strip == "":
    socket.close
    break

echo message
echo "---------="
echo res # responseをどうやって受け取ればいいかわからない。。。


