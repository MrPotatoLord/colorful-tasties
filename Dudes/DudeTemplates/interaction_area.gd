extends StaticBody3D

func _ready() -> void:
	return
	
func interact():
	if "interact" in owner: 
		owner.interact()
	elif "dialogue" in owner and owner.dialogue != "":
		DG.RawText(owner.dialogue)
	else:
		var dialogue: Node = owner.get_node("Dialogue")
		var battle: Node = owner.get_node("Battle")
		if dialogue:
			dialogue.interact()
		elif battle:
			battle.start()
