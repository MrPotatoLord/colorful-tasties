extends StaticBody3D

@export_multiline var dialogue : String
@export var test : BoxShape3D

func _ready() -> void:
	pass
	
func interact():
	if dialogue.is_empty():
		return
		
	# 1. Create a fresh timeline resource in memory
	var timeline: DialogicTimeline = DialogicTimeline.new()
	
	# 2. Split the multiline string by line breaks and assign it to the timeline
	timeline.events = dialogue.split("\n")
	
	# 3. Start Dialogic using the generated resource instead of a file path
	Dialogic.start(timeline)
	Dialogic.start(dialogue)
