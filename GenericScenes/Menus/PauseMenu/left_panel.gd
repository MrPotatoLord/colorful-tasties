extends Control

var target: Control
@onready var selection: Control = $TextureRect/Selection
@onready var buttons = $TextureRect/VBoxContainer.get_children()
@onready var real_buttons = get_tree().get_nodes_in_group("menu_buttons")

func _ready() -> void:
	target = $TextureRect/VBoxContainer.get_child(0)
	selection.size = $TextureRect/VBoxContainer.get_child(0).size
	#selection.position = $TextureRect/VBoxContainer.get_child(0).position
	get_viewport().gui_focus_changed.connect(_on_focus_changedchanged)
	_set_focus()
	buttons[0].focus()


func _process(delta: float) -> void:
	selection.global_position = button_pos_lerp(delta)
	#selection.size.y = max(selection.size.y, lerp(selection.size.y, target.size.y, 5*delta))
	selection.size.y = max(selection.size.y, target.size.y)
	if Input.is_action_just_pressed("interact"):
		_set_focus()


func _set_focus() -> void:
	for i in range(buttons.size()):
		if i+1 != buttons.size():
			buttons[i].set_neigbors(real_buttons[i-1].get_path(), real_buttons[i+1].get_path())
		else:
			buttons[i].set_neigbors(real_buttons[i-1].get_path(), real_buttons[0].get_path())
			
	for i in buttons:
		i.target = selection

func _on_focus_changedchanged(control: Control) -> void:
	target = control.owner

func button_pos_lerp(delta: float) -> Vector2:
	var sonuc = target.global_position.y + (target.size.y - selection.size.y)/2
	return Vector2(0, lerp(selection.global_position.y, sonuc, 5*delta))

func _on_menu_button_2_gting(num) -> void:
	$TextureRect2.position.y = 270.0 + num*10
