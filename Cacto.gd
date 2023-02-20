extends Area2D

onready var dinossauro = get_parent().get_node("Dinossauro")
var altura = Vector2(1630, 708)
var velocidade = Vector2(-1000, 0)
var tempo_vida = 4
var pulou = false
onready var main = get_parent()

func _ready():
	set_position(altura)
	
	connect("area_entered", dinossauro, "colidiu")
	dinossauro.connect("recomecou", self, "recomecou")
	pass

func _physics_process(delta):
	if not main.comecou:
		return
	
	set_position(position + get_node("/root/Main").velocidade * delta)
	
	tempo_vida -= delta
	
	if tempo_vida <= 0:
		queue_free()
	
	# Verifica se jogador já pulou esse cacto e adiciona pontos
	if not pulou:
		if get_position().x < main.get_node("Dinossauro").get_position().x:
			pulou = true
			main.pontos = main.pontos + main.pontuacao_cacto
			main.get_node("Pontos").text = "Pontos: " + str(main.pontos) 

func recomecou():
	main.get_node("Pontos").text = "Pontos: " + str(0) 
	get_parent().get_node("ProgressBar").value = 100
	queue_free()
