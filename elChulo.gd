extends AnimatedSprite

# Variables internas
var scene_BolaMagia
var puede_disparar = true
var contador_atacar = 0
var direccion = Vector2(1, 0)

#Atributos (ataque, velocidad...)
const walk_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_BolaMagia = load("res://BolaMagia.tscn")
	$timer_ataque.connect("timeout", self, "permitir_disparar")
	
func permitir_disparar():
	set_animation("Caminar")
	puede_disparar = true

func _process(delta):
	
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= walk_speed*delta
		set_flip_h(true)
		if puede_disparar:
			set_animation("Caminar")
		direccion = Vector2(-1,0)
		play()
	elif Input.is_key_pressed(KEY_RIGHT):
		position.x += walk_speed*delta
		set_flip_h(false)
		if puede_disparar:
			set_animation("Caminar")
		direccion = Vector2(1,0)
		play()
	elif Input.is_key_pressed(KEY_UP):
		position.y -= walk_speed*delta
		if puede_disparar:
			set_animation("CaminarEspaldas")
		direccion = Vector2(0,-1)
		play()
	elif Input.is_key_pressed(KEY_DOWN):
		position.y += walk_speed*delta
		if puede_disparar:
			set_animation("Caminar")
		direccion = Vector2(0,1)
		play()
	
	else:
		stop() 
		
	if Input.is_key_pressed(KEY_Z):
		if puede_disparar:
			set_animation("Atacar")
			var bola = scene_BolaMagia.instance()
			bola.get_node("bolaMagia").set_scale(get_scale()/4)
			bola.get_node("bolaMagia").set_position(position+direccion*Vector2(25, 25))
			bola.get_node("bolaMagia").set_velocidad(500*direccion)
			get_node("/root/Node2D").add_child(bola)
			puede_disparar = false
			$timer_ataque.start(0.5)
			match contador_atacar:
				0:
					frame = 0
				1:
					frame = 1
			contador_atacar = (contador_atacar+1)%2
