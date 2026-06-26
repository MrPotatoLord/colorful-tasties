extends Control

signal gting(difference: float)
signal pressed()

@export var text := "EQUIPMENT"
@export_color_no_alpha var background := Color(0.0, 0.533, 0.718)
@export_color_no_alpha var shader := Color(0.0, 0.502, 1.0)

var target: Control

# Font tracking variables
var difference: float = 100.0
var last_target_center: float = 0.0
var last_applied_font_size: int = -1 # Used to prevent updating the theme every frame
var text_pos: Vector2

@onready var button: Button = %Button
@onready var label: Label = %Label
@onready var container: Control = %Container
@onready var fx_control: Control = $Control
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var effect: ColorRect = $Control/Effect 


func _ready() -> void:
	button.text = " " + text
	label.text = " " + text
	color_rect.color = background
	effect.material.set("shader_parameter/color", shader)

func _process(_delta: float) -> void:
	if not target:
		return

	var target_center := target.global_position.y + (target.size.y / 2.0)
	var self_center := global_position.y + (size.y / 2.0)
	
	_update_font_size(target_center, self_center)
	
	text_pos = Vector2(0, target.global_position.y + (target.size.y - size.y) / 2.0)
	
	container.global_position = text_pos
	fx_control.global_position = text_pos
	label.global_position = button.global_position

func _draw() -> void:
	if target:
		fx_control.set_deferred("global_position", text_pos) 

func focus() -> void:
	button.grab_focus.call_deferred()

func set_neigbors(top: NodePath, bottom: NodePath) -> void:
	button.focus_neighbor_top = top
	button.focus_neighbor_bottom = bottom

func _update_font_size(target_center: float, self_center: float) -> void:
	var dir := target_center - last_target_center
	var is_towards := ((self_center - target_center) * dir) > 0
	
	if is_towards:
		difference = min(difference, abs(target_center - self_center))
	else:
		difference = max(difference, abs(target_center - self_center))

	gting.emit(difference)
	
	# Use clampf for floats, then cast to int after remap
	var clamped_d := clampf(difference, 2.0, 40.0)
	var mapped_d := int(remap(clamped_d, 2.0, 40.0, 25.0, 0.0))
	var new_font_size := 60 + mapped_d
	
	if new_font_size != last_applied_font_size:
		button.add_theme_font_size_override("font_size", new_font_size)
		label.add_theme_font_size_override("font_size", new_font_size)
		last_applied_font_size = new_font_size

	last_target_center = target_center


func _on_button_pressed() -> void:
	pressed.emit()
