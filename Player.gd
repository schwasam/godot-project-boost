extends RigidBody3D

## Vertical force to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 750.0

## Force to apply when rotating
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		if not rocket_audio.playing:
			rocket_audio.play()
		apply_central_force(basis.y * thrust * delta)
	else:
		rocket_audio.stop()

	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))

	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))


func _on_body_entered(body: Node) -> void:
	if not is_transitioning:
		if body.is_in_group("Goal"):
			var file_path = body.file_path
			Assert.string_not_empty(file_path)
			complete_level(file_path)
		elif body.is_in_group("Failure"):
			crash_sequence()


func complete_level(next_level_file: String) -> void:
	print("Level complete!")
	success_audio.play()
	set_physics_process(false)
	is_transitioning = true
	var tween = create_tween()
	Assert.ignore(tween.tween_interval(success_audio.stream.get_length()))
	Assert.ignore(tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file)))


func crash_sequence() -> void:
	print("Kaboom!")
	explosion_audio.play()
	set_physics_process(false)
	is_transitioning = true
	var tween = create_tween()
	Assert.ignore(tween.tween_interval(explosion_audio.stream.get_length()))
	Assert.ignore(tween.tween_callback(get_tree().reload_current_scene))
