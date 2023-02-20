extends ProgressBar

var altura = Vector2(1630, 708)
var vez = 0
var respirando = false

func _ready():
	WebSocket.connect("respiron", self, "respirando")
	pass
	
func respirando():
	if value < 100 and get_parent().acabou == false:
		value += 0.8

func _process(delta):
	#print(delta)
	#print(value)
	if value <= 100 and get_parent().comecou == true:
		value -= 5 * delta
	
	#if value < 100 and respirando == true and get_parent().acabou == false:
		#print("RESPIROU")
		#value += 50 * delta
		#respirando = false
		
	if value == 0: #nao sei pq deu certo colocar altura como identificador
		if vez == 0:
			get_parent().get_node("Dinossauro").colidiu(altura)
			vez = 1
