extends Node

var txt = ''
var client
var connected = false

signal pulo_dino_b
signal respiron

const ip = "10.0.0.101"
const port = 80


func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	client.connect_to_host(ip,port)
	if(client.is_connected_to_host()):
		connected = true
		print('Conectei')

func _process(delta):
	if connected and not client.is_connected_to_host():
		connected = false
	else:
		_readWebSocket()
	
func _readWebSocket():
	while client.get_available_bytes()>0:
		var message = client.get_utf8_string(client.get_available_bytes())
		
		if message == null:
			continue
		elif message.length()>0:
			
			print(message)
			for i in message:
				if i == '\n':
					_message_interpreter(txt)
					txt = ''
				else:
					txt = txt + i
					
func _message_interpreter(txt):
	var command = txt.split(' ')
	if command[0] == "Respirou":
		#emit_signal("pulo_dino_b")
		print("RESPIROU")
		emit_signal("respiron")
	if command[0] == "Pulou":
		print("PULOU")
		emit_signal("pulo_dino_b")
		
