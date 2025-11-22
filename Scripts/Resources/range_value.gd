class_name RangeValue extends Resource

@warning_ignore("shadowed_global_identifier")
@export var min: int = 1
@warning_ignore("shadowed_global_identifier")
@export var max: int = 10


func get_random_value() -> int:
	return randi_range(min, max)
