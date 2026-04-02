extends AnimatedSprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func walk(dir: Vector2) -> void:
	if dir.is_zero_approx():
		play("default")
		flip_h = false
		#
	#elif dir.x > 0:
		#play("walk_side")
		#flip_h = true
#
	#elif dir.x < 0:
		#play("walk_side")
		#flip_h = false

	else:
		play("walk_forw")
		flip_h = false
