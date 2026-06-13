extends Node
@onready var d3: Node3D = $"3D"
@onready var ui: Control = $UI
@onready var sub_viewport: SubViewport = $UI/SubViewportContainer/SubViewport


var menu_scene := preload("res://GenericScenes/Menus/PauseMenu/menu.tscn")
var menu : Control = null

var is_dialogue := false

func _ready() -> void:
	G.Main = self
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		if !menu:
			menu = menu_scene.instantiate()
			#menu.get_node("LeftPanel").position.x = -1000
			sub_viewport.add_child(menu)
		else:
			menu.queue_free()
