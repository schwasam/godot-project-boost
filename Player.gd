extends RigidBody3D

## Vertical force to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 750.0

## Force to apply when rotating
@export var torque_thrust: float = 100.0


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * thrust * delta)

	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))

	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Goal"):
		complete_level(body.file_path)
	elif body.is_in_group("Failure"):
		crash_sequence()


func complete_level(next_level_file: String) -> void:
	print("Level complete!")
	get_tree().change_scene_to_file(next_level_file)


func crash_sequence() -> void:
	print("Kaboom!")
	get_tree().reload_current_scene()
