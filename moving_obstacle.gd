extends AnimatableBody3D

## Relative destination
@export var relative_destination: Vector3

## Duration of movement
@export var duration: float = 1.0


func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + relative_destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)
