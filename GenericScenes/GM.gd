extends Node
var Main : Node

var is_talking := false
var is_menus := false
var stopped : bool :
	get: return is_talking and is_menus
	

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_started():
	is_talking = true
func _on_timeline_ended():
	is_talking = false
