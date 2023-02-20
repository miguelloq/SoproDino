extends Area2D

signal recomecou
signal colidiu

var altura = Vector2(110, 659)
var gravidade = 3500
var velocidade = Vector2()
var velocidade_pulo = -1600
var modificador_gravidade = 2.3

#var vez_pulo = 0
#var pulo_botao = false

var teste
var comecar
var primeira_vez 

var tempo = 0.0
var intervalo = 3
var intervalo_min = 1
var intervalo_max = 3

var cactos = [preload("res://Cacto1.tscn"),
			  preload("res://Cacto2.tscn"),
			  preload("res://Cacto3.tscn"),
			  preload("res://Cacto4.tscn"),
			  preload("res://Cacto5.tscn"),
			  preload("res://Cacto6.tscn")]

func _ready():
	primeira_vez = 0
	print(primeira_vez)
	comecar = false
	teste = false
	set_position(altura)
	randomize()
	$AnimationPlayer.play("parado")
	WebSocket.connect("pulo_dino_b", self, "_pulo_botao")
	WebSocket.connect("pulo_dino_b", self, "_comecar_botao")
	pass
	
func _comecar_botao():
	if primeira_vez == 0:
		comecar = true
	primeira_vez = 1
	
func _pulo_botao():
	#print(teste)
	teste = true
	#print(teste)
	
	#velocidade.y = velocidade_pulo
	
	 #if (vez_pulo == 0):
			#pulo_botao = true
			#vez_pulo = 1
		

func _physics_process(delta):
	if not get_parent().comecou:
		return
	
	tempo += delta
	
	if tempo >= intervalo:
		tempo = 0
		
		# SORTEIA O TIPO DE CACTO
		var c = rand_range(0, cactos.size())
		
		get_parent().add_child(cactos[c].instance())
		
		# SORTEIA O TEMPO DO PROXIMO CACTO
		intervalo = rand_range(intervalo_min, intervalo_max)
		
		
	if teste == true:#teste == true: #Input.is_action_pressed("pular"): #or pulo_botao == true:
		velocidade.y += gravidade * delta
		
		
	else :
		velocidade.y += gravidade * delta * modificador_gravidade
	
	if position == altura and teste == true:#teste == true:
		velocidade.y = velocidade_pulo
		$Jump.play()
		teste = false
		
	position += velocidade * delta
	
	# 'COLISAO' COM O CHAO
	if get_position().y > altura.y :
		set_position(altura)
		velocidade = Vector2()

func colidiu(area):
	$AnimationPlayer.play("morto")
	emit_signal("colidiu")
	
	#teste = false
	get_parent().comecou = false
	get_parent().acabou = true
	
		
	#queue_free()

func _input(event):
	if Input.is_action_pressed("pular") and get_parent().comecou == false and get_parent().acabou == false:
		if get_parent().acabou and not event.is_echo():
			get_parent().pontos = 0
			emit_signal("recomecou")
			
			get_parent().acabou = false
		
			
		get_parent().comecou = true
		teste = false
		$AnimationPlayer.play("andando")
		$ThemeSong.play()
