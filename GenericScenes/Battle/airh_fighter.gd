class_name AirHFighter extends Resource

@export var action_name: String
@export var damage: int

# This is the slot for your unique built-in script
@export var custom_logic: GDScript 

func execute(target: Node):
	# Check if a unique script has been assigned
	if custom_logic:
		# Create an instance of the built-in script in memory
		var logic_instance = custom_logic.new()
		
		# Call the specific function you expect the script to have
		if logic_instance.has_method("run"):
			logic_instance.run(target, self)
		else:
			push_warning("Custom logic script is missing a 'run()' method.")
