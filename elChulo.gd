extends Area2D

# Variables internas
var scene_BolaMagia
var puede_disparar = true
var contador_atacar = 0
var direccion = Vector2(1, 0)

#Atributos (ataque, velocidad...)
const walk_speed = 200   #píxeles/segundo
const cadencia = 0.5	#tiempo entre disparos

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_BolaMagia = load("res://BolaMagia.tscn")
	$timer_ataque.connect("timeout", self, "permitir_disparar")
	
func permitir_disparar():
	$sprite_el_chulo.set_animation("Caminar")
	puede_disparar = true
	
func mover_izquierda(delta):
	position.x -= walk_speed*delta
	$sprite_el_chulo.set_flip_h(true)
	if puede_disparar:
		$sprite_el_chulo.set_animation("Caminar")
	direccion = Vector2(-1,0)
	$sprite_el_chulo.play()
	
func mover_derecha(delta):
	position.x += walk_speed*delta
	$sprite_el_chulo.set_flip_h(false)
	if puede_disparar:
		$sprite_el_chulo.set_animation("Caminar")
	direccion = Vector2(1,0)
	$sprite_el_chulo.play()
	
func mover_arriba(delta):
	position.y -= walk_speed*delta
	if puede_disparar:
		$sprite_el_chulo.set_animation("CaminarEspaldas")
	direccion = Vector2(0,-1)
	$sprite_el_chulo.play()
	
func mover_abajo(delta):
	position.y += walk_speed*delta
	if puede_disparar:
		$sprite_el_chulo.set_animation("Caminar")
	direccion = Vector2(0,1)
	$sprite_el_chulo.play()
	
func detener():
	$sprite_el_chulo.stop() 

func _process(delta):
		
	if Input.is_key_pressed(KEY_Z):
		if puede_disparar:
			$sprite_el_chulo.set_animation("Atacar")
			var bola = scene_BolaMagia.instance()
			bola.get_node("bolaMagia").set_scale($sprite_el_chulo.get_scale()/4)
			bola.get_node("bolaMagia").set_position(position+direccion*Vector2(25, 25))
			bola.get_node("bolaMagia").set_velocidad(500*direccion)
			get_parent().add_child(bola)
			puede_disparar = false
			$timer_ataque.start(cadencia)
			match contador_atacar:
				0:
					$sprite_el_chulo.frame = 0
				1:
					$sprite_el_chulo.frame = 1
			contador_atacar = (contador_atacar+1)%2

