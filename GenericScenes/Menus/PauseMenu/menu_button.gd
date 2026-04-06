extends Control


@export var text := "EQUIPMENT"
@export_color_no_alpha var background := Color(0.0, 0.533, 0.718)
@export_color_no_alpha var shader := Color(0.0, 0.502, 1.0)
signal gting

var target : Control
var time := 0.0


#fontstuff
var target_center: float
var self_center : float
var difference : float = 100.0
var last_target_center : float
#var last_difference : float
#var difdif : float
var clamped_d : int
var clamped_m : int


func _ready() -> void:
	%Button.text = " " + text
	%Label.text = " " + text
	$Control/ColorRect.color = background
	$Control/Effect.material.set("shader_parameter/color", shader)

func _process(delta: float) -> void:
	
	
	if target:

		target_center = target.global_position.y + target.size.y / 2
		self_center = global_position.y + size.y / 2
		_fonty_size.call_deferred()
		

		
		%Container.global_position = get_text_pos()
		$Control.global_position = get_text_pos()
		
		%Label.global_position = %Button.global_position
		
		

func _draw() -> void:
	if target:
		$Control.set_deferred("global_position", get_text_pos())
		
func focus() -> void:
	%Button.grab_focus.call_deferred()

	
func set_neigbors(top: NodePath, bottom: NodePath) -> void:
	%Button.focus_neighbor_top = top
	%Button.focus_neighbor_bottom = bottom

func get_text_pos() -> Vector2:
	return Vector2(0, target.global_position.y + (target.size.y - size.y)/2)
	#Vector2(0, target.global_position.y)


func _fonty_size() -> void:

	
	
	var dir := target_center - last_target_center

	var is_towards := true if ((self_center - target_center) * dir) > 0 else false
	
	if is_towards:
		difference = min(difference, abs(target_center - self_center))
	else:
		difference = max(difference, abs(target_center - self_center))

	
	clamped_d = clamp(difference, 2, 40)
	clamped_d = remap(clamped_d, 2, 40, 25, 0)
	gting.emit(difference)
	
	
	
	%Button.add_theme_font_size_override("font_size", 60+clamped_d)
	%Label.add_theme_font_size_override("font_size", 60+clamped_d)
	last_target_center = target_center
	
func _fonty_reresize() -> void:
	target_center = target.global_position.y + target.size.y / 2
	self_center = global_position.y + size.y / 2
	difference = abs(target_center - self_center)
	clamped_d = clamp(difference, 2, 40)
	clamped_d = remap(clamped_d, 2.0, 40.0, 1.4, 1.0)
	
	
	
	#if button.text[-1] == " ":
		#button.text = button.text.left(-1)
	#else:
		#button.text += " "
		
	size = Vector2(clamped_d, clamped_d)

func _fonty_resize() -> void:
	target_center = target.global_position.y + target.size.y / 2
	self_center = global_position.y + size.y / 2
	difference = abs(target_center - self_center)
	clamped_d = clamp(difference, 2, 40)
	clamped_d = remap(clamped_d, 2.0, 40.0, 1.4, 1.0)
	
	if %Button.text[-1] == " ":
		%Button.text = %Button.text.left(-1)
	else:
		%Button.text += " "
		
	%Button.scale = Vector2(clamped_d, clamped_d)
	$Button/Container/Label.scale = Vector2(clamped_d, clamped_d)
	#print(Vector2(clamped_d, clamped_d))
