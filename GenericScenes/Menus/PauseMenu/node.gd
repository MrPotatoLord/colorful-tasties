@tool
extends Node



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		%Button.text = " " + $"..".text
		%Label.text = " " + $"..".text
		$"../Control/ColorRect".color = $"..".background
		$"../Control/Effect".material.set("shader_parameter/color", $"..".shader)
