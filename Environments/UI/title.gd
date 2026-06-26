extends Control

@onready var play_button : TextureButton = $Play
@onready var quit_button : TextureButton = $Quit

func _ready() -> void:
	play_button.pressed.connect(func(): GM.Main.begin_game())
	quit_button.pressed.connect(func(): get_tree().quit())

