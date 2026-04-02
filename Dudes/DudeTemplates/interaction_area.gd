extends StaticBody3D

@export var dialogue : DialogicTimeline
@export var test : BoxShape3D

func _ready() -> void:
	pass
	
func interact():
	Dialogic.start(dialogue)
