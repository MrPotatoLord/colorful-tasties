extends Area3D
@onready var head_collision: CollisionShape3D = $"../HeadCollision"



func _on_body_entered(body: Node3D) -> void:
	head_collision.disabled = false # Replace with function body.


func _on_body_exited(body: Node3D) -> void:
	await get_tree().create_timer(1).timeout 
	head_collision.disabled = true # Replace with function body.
