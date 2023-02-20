extends Node

var velocidade = Vector2(-890, 0)
var velocidade_inicial = velocidade
var offset_inicial = Vector2()
var comecou = false
var acabou = false
var pontuacao_cacto = 10
var pontos = 0
var record = 0

func _ready():
	get_node("Dinossauro").connect("recomecou", self, "quando_recomecou")
	$Button.hide()
	$Label.hide()
	pass

func _process(delta):
	if not comecou:
		return
		
	velocidade.x -= delta/5

func quando_recomecou():
	velocidade = velocidade_inicial
	$ParallaxBackground.set_scroll_offset(offset_inicial)
	$Label.hide()
	$Button.hide()
	
	#get_parent().get_node("Pontos").text = "Pontos: " + str(pontos)
	
	
func _on_Dinossauro_colidiu():
	$Label.show()
	$Button.show()
	$Dinossauro/ThemeSong.stop()
	$Dinossauro/Die.play()


func _on_Button_pressed():
		$Label.hide()
		$Button.hide()
		pontos = 0
		acabou = false
		get_node("Pontos").text = "Pontos: " + str(0) 
		comecou = true
		$ProgressBar.value = 100
		$Dinossauro/AnimationPlayer.play("andando")
		get_tree().change_scene("res://Main.tscn")

		
		
		
		
		
		
	
	
