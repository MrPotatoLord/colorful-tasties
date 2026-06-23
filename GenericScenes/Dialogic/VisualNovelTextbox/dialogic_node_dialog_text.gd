extends DialogicNode_DialogText

var base_window_size: Vector2 = Vector2(1920.0, 1080.0)

func _ready() -> void:
	super._ready()
	get_tree().root.size_changed.connect(_on_window_resized)
	await get_tree().create_timer(0.1).timeout
	_on_window_resized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if Input.is_action_just_pressed("close"):
		finish_text()

func _on_window_resized() -> void:
	var current_window_size: Vector2 = Vector2(get_window().size)
	
	var ratio: float = base_window_size.x / current_window_size.x
	
	var final_scale: float = max(1.0, ratio)
	
	%DialogicNode_DialogText.add_theme_font_size_override("normal_font_size", int(15*final_scale))
	# Apply the scale to this Control node
	#%Sizer.scale = Vector2(final_scale, final_scale)
	#%Sizer.position = Vector2(final_scale, final_scale) * Vector2(-0.5, -1)+Vector2(0, -15)
