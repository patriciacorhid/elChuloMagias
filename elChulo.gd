extends AnimatedSprite

# Declare member variables here. Examples:
var scene_BolaMagia
var puede_disparar = true
var contador_atacar = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	scene_BolaMagia = load("res://BolaMagia.tscn")
	$Timer.connect("timeout", self, "permitir_disparar")
	
func permitir_disparar():
	set_animation("Caminar")
	puede_disparar = true

func _process(delta):
	if Input.is_key_pressed(KEY_Z):
		if puede_disparar:
			set_animation("Atacar")
			var bola = scene_BolaMagia.instance()
			bola.get_node("bolaMagia").set_scale(get_scale()/4)
			bola.get_node("bolaMagia").set_position(position+Vector2(15, 5))
			bola.get_node("bolaMagia").set_velocidad(Vector2(500, 0))
			get_parent().add_child(bola)
			puede_disparar = false
			$Timer.start(0.5)
			match contador_atacar:
				0:
					frame = 0
				1:
					frame = 1
			contador_atacar = (contador_atacar+1)%2
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= 10
		set_flip_h(true)
	if Input.is_key_pressed(KEY_RIGHT):
		position.x += 10
		set_flip_h(false)
	if Input.is_key_pressed(KEY_UP):
		position.y -= 10
	if Input.is_key_pressed(KEY_DOWN):
		position.y += 10
