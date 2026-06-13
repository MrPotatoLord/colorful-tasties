extends Object


func PlayRawText(dialogue: String):
	var timeline: DialogicTimeline = DialogicTimeline.new()
	
	# 2. Split the multiline string by line breaks and assign it to the timeline
	timeline.events = dialogue.split("\n")
	print(timeline.events)
	
	# 3. Start Dialogic using the generated resource instead of a file path
	#Dialogic.start(timeline)
	return timeline

func NewTimeline():
	return DialogicTimeline.new()