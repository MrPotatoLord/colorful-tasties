extends Node
@onready var ddd: Node3D = $"3D"
@onready var ui: Control = $UI
@onready var sub_viewport: SubViewport = $UI/SubViewportContainer/SubViewport

var current_3d : Node3D
var current_2d : Node2D
@onready var current_ui : Control = $UI/Title

var overworld_scene := preload("res://Environments/template_level.tscn")

var title_scene := preload("res://Environments/UI/title.tscn")

var menu_scene := preload("res://GenericScenes/Menus/PauseMenu/menu.tscn")
var menu : Control = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.Main = self
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		if !menu:
			menu = menu_scene.instantiate()
			#menu.get_node("LeftPanel").position.x = -1000
			sub_viewport.add_child(menu)
		else:
			menu.queue_free()

func begin_game():
	remove_ui(current_ui)
	current_ui = null
	replace_3d(overworld_scene)

func exit_game():
	remove_3d(current_3d)
	current_3d = null
	replace_ui(title_scene)
	
	
	

func replace_3d(scene: PackedScene) -> Node3D:
	if current_3d:
		remove_3d(current_3d)
	current_3d = add_3d(scene)
	return current_3d

func add_3d(scene: PackedScene) -> Node3D:
		var node := scene.instantiate()
		ddd.add_child(node)
		return node
		
func remove_3d(node: Node3D) -> void:
	node.queue_free()
	
func replace_ui(scene: PackedScene) -> Control:
	if current_ui:
		remove_ui(current_ui)
	current_ui = add_ui(scene)
	return current_ui

func add_ui(scene: PackedScene) -> Control:
		var node := scene.instantiate()
		ui.add_child(node)
		return node
		
func remove_ui(node: Control) -> void:
	node.queue_free()
