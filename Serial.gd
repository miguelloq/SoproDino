extends Node
const serial_res = preload("res://bin/gdserial.gdns")
var serial_port = serial_res.new()
var is_port_open = false
var msg = ''
signal pulou 

func _ready():
	serial_port.open_port('COM3', 115200)



func _process(delta):
	if(is_port_open):
		var message = serial_port.read_text()
		if(message.length() > 0):
			for i in message:
				if(i =='\n'):
					print(msg)
					msg = ''
				else:
					msg =  msg+i
					
func _text_interpreter(msg):
	var command = msg.split(' ')
	if (command[0]=='Pulou'):
		emit_signal("pulou")
