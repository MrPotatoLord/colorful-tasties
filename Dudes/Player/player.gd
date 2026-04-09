extends CharacterBody3D
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D



const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var ray_length: int = ray_cast_3d.target_position.length() as int
@onready var ray_pos: int = ray_cast_3d.position.length()  as int


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if !GM.stopped:
		_move(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"), delta)
	else:
		_move(Vector2.ZERO, delta)


	move_and_slide()

func _move(input_dir: Vector2, _delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	animated_sprite_3d.walk(input_dir)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:

		ray_cast_3d.target_position = direction * ray_length 
		ray_cast_3d.position = -direction * ray_pos

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
func _input(event: InputEvent) -> void:
	if !GM.stopped:
		if event.is_action_pressed("interact"):
			if $RayCast3D.get_collider():
				var interaction = $RayCast3D.get_collider() as StaticBody3D
				interaction.interact()
