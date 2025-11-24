class_name DamageLabel extends Label


func _ready() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.2)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.5).set_delay(0.4)
	tween.tween_property(self, "position:y", global_position.y - 80, 2.0).set_delay(0.4)
	await tween.finished
	queue_free()
	