extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var posicion_chulo = $ElChulo.position
	
	if Input.is_key_pressed(KEY_LEFT):
		$ElChulo.mover_izquierda(delta)
	elif Input.is_key_pressed(KEY_RIGHT):
		$ElChulo.mover_derecha(delta)
	elif Input.is_key_pressed(KEY_UP):
		$ElChulo.mover_arriba(delta)
	elif Input.is_key_pressed(KEY_DOWN):
		$ElChulo.mover_abajo(delta)
	else:
		$ElChulo.detener()
