extends Area2D

# Declare member variables here. Examples:
var velocidad = Vector2(0, 0)

func set_velocidad(v):
	velocidad = v

func _process(delta):
	position.x += velocidad.x*delta
	position.y += velocidad.y*delta
