class_name DG
extends Node

static func RawText(dialogue: String) -> void:
	var timeline: DialogicTimeline = DialogicTimeline.new()
	
	# 2. Split the multiline string by line breaks and assign it to the timeline
	timeline.events = dialogue.split("\n")
	
	# 3. Start Dialogic using the generated resource instead of a file path
	Dialogic.start(timeline)
