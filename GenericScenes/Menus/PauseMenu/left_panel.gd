extends Control

var target: Control

@onready var texture_rect_2: TextureRect = $TextureRect2 
@onready var selection: Control = $TextureRect/Selection
@onready var vbox_container: VBoxContainer = $TextureRect/VBoxContainer
@onready var buttons: Array[Node] = vbox_container.get_children()
@onready var real_buttons: Array[Node] = get_tree().get_nodes_in_group("menu_buttons")

func _ready() -> void:
	target = buttons[0]
	selection.size = target.size
	
	get_viewport().gui_focus_changed.connect(_on_focus_changedchanged)
	
	_setup_menu()
	
	buttons[0].focus()

func _process(delta: float) -> void:
	var target_y := target.global_position.y + (target.size.y - selection.size.y) / 2.0
	selection.global_position.y = lerp(selection.global_position.y, target_y, 5.0 * delta)
	
	#selection.size.y = max(selection.size.y, target.size.y) 
	
	if Input.is_action_just_pressed("interact"):
		_setup_menu()

func _setup_menu() -> void:
	var count := buttons.size()

	for i in range(count):
		var prev_node := real_buttons[i - 1]
		var next_node := real_buttons[(i + 1) % count] 
		
		buttons[i].set_neigbors(prev_node.get_path(), next_node.get_path())
		buttons[i].target = selection

func _on_focus_changedchanged(control: Control) -> void:
	target = control.owner

func _on_menu_button_2_gting(num: float) -> void:
	texture_rect_2.position.y = 270.0 + (num * 10.0)
