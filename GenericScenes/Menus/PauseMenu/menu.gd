extends Control
@onready var left_panel: Control = $LeftPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_panel.position.x = -2000
	G.IsMenus = true

func _exit_tree() -> void:
	G.IsMenus = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	left_panel.position.x = lerp(left_panel.position.x, 0.0, 0.2)
