extends RigidBody3D

## Vertical force to apply when moving
@export_range(750.0, 3000.0) var thrust: float = 750.0

## Force to apply when rotating
@export var torque_thrust: float = 100.0

var is_transitioning: bool = false

# Audio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio

# Particles
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * thrust * delta)
		booster_particles.emitting = true
		if not rocket_audio.playing:
			rocket_audio.play()
	else:
		booster_particles.emitting = false
		rocket_audio.stop()

	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false

	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


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
	rocket_audio.stop()
	set_physics_process(false)
	is_transitioning = true
	success_particles.emitting = true
	success_audio.play()
	var tween = create_tween()
	Assert.ignore(tween.tween_interval(success_audio.stream.get_length()))
	Assert.ignore(tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file)))


func crash_sequence() -> void:
	print("Kaboom!")
	rocket_audio.stop()
	set_physics_process(false)
	is_transitioning = true
	explosion_particles.emitting = true
	explosion_audio.play()
	var tween = create_tween()
	Assert.ignore(tween.tween_interval(explosion_audio.stream.get_length()))
	Assert.ignore(tween.tween_callback(get_tree().reload_current_scene))
